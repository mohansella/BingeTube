import 'dart:convert';
import 'dart:io';

import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/port/sery_port.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/core/utils/file_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

class LibraryExportProgress {
  final int exported;
  final int total;
  final String label;

  const LibraryExportProgress({
    required this.exported,
    required this.total,
    required this.label,
  });
}

class LibraryImportProgress {
  final int imported;
  final int total;
  final String label;

  const LibraryImportProgress({
    required this.imported,
    required this.total,
    required this.label,
  });
}

sealed class LibraryPort {
  static const masterFileName = 'library.json';
  static final _logger = LogManager.getLogger('LibraryPort');

  static Future<String?> pickExportDirectory() {
    return FilePicker.getDirectoryPath(
      dialogTitle: 'Select folder to export your library:',
    );
  }

  static Future<String?> pickImportDirectory() {
    return FilePicker.getDirectoryPath(
      dialogTitle: 'Select folder to import your library:',
    );
  }

  static Future<String> exportAllToDirectory(
    String directoryPath, {
    void Function(LibraryExportProgress progress)? onProgress,
  }) async {
    final exportDir = Directory(directoryPath);
    await exportDir.create(recursive: true);

    final bingeDao = BingeDao(Database());
    final collections = await bingeDao.getCollectionsByPriority(isSystem: false);
    final collectionIdVsSeries = <int, List<Sery>>{};
    var totalSeries = 0;

    for (final collection in collections) {
      final series = await bingeDao.getSeriesForCollection(collection.id);
      collectionIdVsSeries[collection.id] = series;
      totalSeries += series.length;
    }

    var exported = 0;
    onProgress?.call(
      LibraryExportProgress(
        exported: exported,
        total: totalSeries,
        label: 'Preparing library export',
      ),
    );

    final usedCollectionDirs = <String>{};
    final masterCollections = <Map<String, dynamic>>[];

    for (final collection in collections) {
      final collectionDirName = _uniquePathSegment(
        collection.name,
        usedCollectionDirs,
        fallback: 'collection',
      );
      final collectionDir = Directory(p.join(exportDir.path, collectionDirName));
      await collectionDir.create(recursive: true);

      final usedSeriesFiles = <String>{};
      final seriesPaths = <String>[];
      final series = collectionIdVsSeries[collection.id] ?? [];

      for (final sery in series) {
        final model = await bingeDao.streamBingeModel(sery.id).first;
        final fileName = _uniqueFileName(
          SeryPort.buildFileName(model.title),
          usedSeriesFiles,
        );
        final file = File(p.join(collectionDir.path, fileName));

        await SeryPort.exportToFile(model, file);

        exported++;
        seriesPaths.add(p.posix.join(collectionDirName, fileName));
        onProgress?.call(
          LibraryExportProgress(
            exported: exported,
            total: totalSeries,
            label: model.title,
          ),
        );
      }

      masterCollections.add({
        'name': collection.name,
        'description': collection.description,
        'series': seriesPaths,
      });
    }

    onProgress?.call(
      LibraryExportProgress(
        exported: exported,
        total: totalSeries,
        label: 'Writing library index',
      ),
    );

    final masterJson = {
      'version': 1,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'collections': masterCollections,
    };
    const encoder = JsonEncoder.withIndent('  ');
    final masterFile = File(p.join(exportDir.path, masterFileName));
    await masterFile.writeAsString('${encoder.convert(masterJson)}\n');

    _logger.info('exported library to ${exportDir.path}');
    return exportDir.path;
  }

  static Future<String> importAllFromDirectory(
    String directoryPath, {
    void Function(LibraryImportProgress progress)? onProgress,
  }) async {
    final importDir = Directory(directoryPath);
    final masterFile = File(p.join(importDir.path, masterFileName));
    if (!await masterFile.exists()) {
      throw FileSystemException('Library index not found', masterFile.path);
    }

    final manifest = await _readManifest(masterFile);
    await _validateManifestFiles(importDir, manifest);
    final totalSeries = manifest.fold<int>(
      0,
      (total, collection) => total + collection.seriesPaths.length,
    );

    var imported = 0;
    onProgress?.call(
      LibraryImportProgress(
        imported: imported,
        total: totalSeries,
        label: 'Reading library index',
      ),
    );

    final bingeDao = BingeDao(Database());
    final existingCollections = await bingeDao.getCollectionsByPriority(isSystem: false);
    var collectionPriority = existingCollections.fold<int>(
      0,
      (maxPriority, collection) =>
          collection.priority > maxPriority ? collection.priority : maxPriority,
    );

    for (final manifestCollection in manifest) {
      final collection = await bingeDao.createCollection(
        name: manifestCollection.name,
        description: manifestCollection.description,
        isSystem: false,
        priority: ++collectionPriority,
      );

      var seriesPriority = 0;
      for (final seriesPath in manifestCollection.seriesPaths) {
        final file = _resolveManifestFile(importDir, seriesPath);
        final data = await file.readAsBytes();
        final sery = await SeryPort.import(
          data,
          collectionId: collection.id,
          priority: ++seriesPriority,
        );

        imported++;
        onProgress?.call(
          LibraryImportProgress(imported: imported, total: totalSeries, label: sery.name),
        );
      }
    }

    _logger.info('imported library from ${importDir.path}');
    return importDir.path;
  }

  static Future<List<_LibraryCollectionManifest>> _readManifest(File file) async {
    final content = await file.readAsString();
    final json = jsonDecode(content);
    if (json is! Map<String, dynamic>) {
      throw FormatException('Invalid library index');
    }

    final collectionsJson = json['collections'];
    if (collectionsJson is! List) {
      throw FormatException('Invalid library collections');
    }

    final collections = <_LibraryCollectionManifest>[];
    for (final collectionJson in collectionsJson) {
      if (collectionJson is! Map<String, dynamic>) {
        throw FormatException('Invalid library collection');
      }

      final name = collectionJson['name'];
      final description = collectionJson['description'];
      final seriesJson = collectionJson['series'];
      if (name is! String || seriesJson is! List) {
        throw FormatException('Invalid library collection fields');
      }

      final seriesPaths = <String>[];
      for (final seriesPath in seriesJson) {
        if (seriesPath is! String) {
          throw FormatException('Invalid library series path');
        }
        seriesPaths.add(seriesPath);
      }

      collections.add(
        _LibraryCollectionManifest(
          name: name,
          description: description is String ? description : '',
          seriesPaths: seriesPaths,
        ),
      );
    }
    return collections;
  }

  static Future<void> _validateManifestFiles(
    Directory directory,
    List<_LibraryCollectionManifest> manifest,
  ) async {
    for (final collection in manifest) {
      for (final seriesPath in collection.seriesPaths) {
        final file = _resolveManifestFile(directory, seriesPath);
        if (!await file.exists()) {
          throw FileSystemException('Series export not found', file.path);
        }
      }
    }
  }

  static File _resolveManifestFile(Directory directory, String manifestPath) {
    final normalized = p.posix.normalize(manifestPath);
    if (p.posix.isAbsolute(normalized) || normalized.startsWith('../')) {
      throw FormatException('Invalid library series path: $manifestPath');
    }

    return File(p.joinAll([directory.path, ...p.posix.split(normalized)]));
  }

  static String _uniquePathSegment(
    String input,
    Set<String> used, {
    required String fallback,
  }) {
    final slug = FileUtils.toSlugFileName(input);
    final base = slug.isEmpty ? fallback : slug;
    var candidate = base;
    var suffix = 2;

    while (!used.add(candidate)) {
      candidate = '$base-${suffix++}';
    }
    return candidate;
  }

  static String _uniqueFileName(String fileName, Set<String> used) {
    final extension = p.extension(fileName);
    final name = p.basenameWithoutExtension(fileName);
    final base = name.isEmpty ? 'series' : name;
    var candidate = '$base$extension';
    var suffix = 2;

    while (!used.add(candidate)) {
      candidate = '$base-${suffix++}$extension';
    }
    return candidate;
  }
}

class _LibraryCollectionManifest {
  final String name;
  final String description;
  final List<String> seriesPaths;

  const _LibraryCollectionManifest({
    required this.name,
    required this.description,
    required this.seriesPaths,
  });
}
