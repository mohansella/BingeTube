import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/port/sery_port.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/core/utils/file_download.dart' as file_download;
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

class LibraryImportArchive {
  final String label;
  final Uint8List bytes;

  const LibraryImportArchive({required this.label, required this.bytes});
}

class LibraryExportPreview {
  final List<LibraryExportCollectionPreview> collections;

  const LibraryExportPreview({required this.collections});

  int get totalSeries =>
      collections.fold(0, (total, collection) => total + collection.series.length);
}

class LibraryExportCollectionPreview {
  final Collection collection;
  final List<Sery> series;

  const LibraryExportCollectionPreview({required this.collection, required this.series});
}

class LibraryImportPreview {
  final String label;
  final List<LibraryImportCollectionPreview> collections;

  const LibraryImportPreview({required this.label, required this.collections});

  int get totalSeries =>
      collections.fold(0, (total, collection) => total + collection.series.length);
}

class LibraryImportCollectionPreview {
  final int index;
  final String name;
  final String description;
  final List<LibraryImportSeriesPreview> series;

  const LibraryImportCollectionPreview({
    required this.index,
    required this.name,
    required this.description,
    required this.series,
  });
}

class LibraryImportSeriesPreview {
  final String path;
  final String title;

  const LibraryImportSeriesPreview({required this.path, required this.title});
}

class LibraryExportSelection {
  final Map<int, Set<int>> collectionIdVsSeriesIds;

  LibraryExportSelection(Map<int, Set<int>> collectionIdVsSeriesIds)
    : collectionIdVsSeriesIds = {
        for (final entry in collectionIdVsSeriesIds.entries)
          entry.key: Set.unmodifiable(entry.value),
      };

  bool get isEmpty => collectionIdVsSeriesIds.isEmpty;

  bool includesCollection(int collectionId) {
    return collectionIdVsSeriesIds.containsKey(collectionId);
  }

  bool includesSeries(int collectionId, int seriesId) {
    return collectionIdVsSeriesIds[collectionId]?.contains(seriesId) ?? false;
  }
}

class LibraryImportSelection {
  final Map<int, Set<String>> collectionIndexVsSeriesPaths;

  LibraryImportSelection(Map<int, Set<String>> collectionIndexVsSeriesPaths)
    : collectionIndexVsSeriesPaths = {
        for (final entry in collectionIndexVsSeriesPaths.entries)
          entry.key: Set.unmodifiable(entry.value),
      };

  bool get isEmpty => collectionIndexVsSeriesPaths.isEmpty;

  bool includesCollection(int collectionIndex) {
    return collectionIndexVsSeriesPaths.containsKey(collectionIndex);
  }

  bool includesSeries(int collectionIndex, String seriesPath) {
    return collectionIndexVsSeriesPaths[collectionIndex]?.contains(seriesPath) ?? false;
  }
}

sealed class LibraryPort {
  static const masterFileName = 'library.json';
  static const archiveExtension = 'binges';
  static const archiveBaseFileName = 'bingetube-library';
  static const archiveFileName = '$archiveBaseFileName.$archiveExtension';
  static const archiveMimeType = 'application/octet-stream';
  static final _logger = LogManager.getLogger('LibraryPort');

  static Future<LibraryImportArchive?> pickImportArchive() async {
    final result = await FilePicker.pickFiles(
      dialogTitle: 'Select library export:',
      type: .custom,
      allowedExtensions: [archiveExtension],
      withData: true,
    );
    final file = result?.files.singleOrNull;
    final bytes = file?.bytes;
    if (file == null || bytes == null) {
      return null;
    }

    return LibraryImportArchive(label: file.name, bytes: bytes);
  }

  static Future<LibraryExportPreview> getExportPreview() async {
    final bingeDao = BingeDao(Database());
    final collections = await bingeDao.getCollectionsByPriority(isSystem: false);
    final previewCollections = <LibraryExportCollectionPreview>[];
    for (final collection in collections) {
      previewCollections.add(
        LibraryExportCollectionPreview(
          collection: collection,
          series: await bingeDao.getSeriesForCollection(collection.id),
        ),
      );
    }
    return LibraryExportPreview(collections: previewCollections);
  }

  static Future<LibraryImportPreview> previewImport(LibraryImportArchive archive) async {
    final decodedArchive = ZipDecoder().decodeBytes(archive.bytes);
    final masterFile = decodedArchive.findFile(masterFileName);
    if (masterFile == null) {
      throw const FormatException('Library index not found');
    }

    final manifest = _readManifestContent(utf8.decode(masterFile.content));
    _validateArchiveManifestFiles(decodedArchive, manifest);

    final collections = <LibraryImportCollectionPreview>[];
    for (var i = 0; i < manifest.length; i++) {
      final manifestCollection = manifest[i];
      final previewSeries = <LibraryImportSeriesPreview>[];
      for (final seriesPath in manifestCollection.seriesPaths) {
        final seriesFile = _resolveManifestArchiveFile(decodedArchive, seriesPath);
        previewSeries.add(
          LibraryImportSeriesPreview(
            path: seriesPath,
            title: SeryPort.readExportTitle(seriesFile.content),
          ),
        );
      }

      collections.add(
        LibraryImportCollectionPreview(
          index: i,
          name: manifestCollection.name,
          description: manifestCollection.description,
          series: previewSeries,
        ),
      );
    }

    return LibraryImportPreview(label: archive.label, collections: collections);
  }

  static Future<String?> exportAll({
    LibraryExportSelection? selection,
    void Function(LibraryExportProgress progress)? onProgress,
    bool Function()? isCancelled,
  }) async {
    final bytes = await _buildArchiveBytes(
      selection: selection,
      onProgress: onProgress,
      isCancelled: isCancelled,
    );
    if (bytes == null || _isCancelled(isCancelled)) {
      _logger.info('library archive export cancelled');
      return null;
    }

    final filePath = await file_download.saveFile(
      dialogTitle: 'Save library export:',
      fileName: archiveFileName,
      fileBaseName: archiveBaseFileName,
      extension: archiveExtension,
      bytes: bytes,
      mimeType: archiveMimeType,
    );
    if (filePath == null) {
      _logger.info('library archive export cancelled');
      return null;
    }

    _logger.info('exported library archive at $filePath');
    return filePath;
  }

  static Future<String?> importAll(
    LibraryImportArchive archive, {
    LibraryImportSelection? selection,
    void Function(LibraryImportProgress progress)? onProgress,
    bool Function()? isCancelled,
  }) async {
    if (_isCancelled(isCancelled)) {
      _logger.info('library archive import cancelled');
      return null;
    }

    final decodedArchive = ZipDecoder().decodeBytes(archive.bytes);
    final masterFile = decodedArchive.findFile(masterFileName);
    if (masterFile == null) {
      throw const FormatException('Library index not found');
    }

    final manifest = _readManifestContent(utf8.decode(masterFile.content));
    if (_isCancelled(isCancelled)) {
      _logger.info('library archive import cancelled');
      return null;
    }

    final selectedManifest = _filterManifest(manifest, selection);
    _validateArchiveManifestFiles(decodedArchive, selectedManifest);
    final didComplete = await _importManifest(
      selectedManifest,
      onProgress: onProgress,
      isCancelled: isCancelled,
      readSeriesBytes: (seriesPath) async {
        return _resolveManifestArchiveFile(decodedArchive, seriesPath).content;
      },
    );
    if (!didComplete || _isCancelled(isCancelled)) {
      _logger.info('library archive import cancelled');
      return null;
    }

    _logger.info('imported library from archive ${archive.label}');
    return archive.label;
  }

  static Future<Uint8List?> _buildArchiveBytes({
    LibraryExportSelection? selection,
    void Function(LibraryExportProgress progress)? onProgress,
    bool Function()? isCancelled,
  }) async {
    final archive = Archive();
    final bingeDao = BingeDao(Database());
    final allCollections = await bingeDao.getCollectionsByPriority(isSystem: false);
    final collections = selection == null
        ? allCollections
        : allCollections.where((c) => selection.includesCollection(c.id)).toList();
    final collectionIdVsSeries = <int, List<Sery>>{};
    var totalSeries = 0;

    for (final collection in collections) {
      if (_isCancelled(isCancelled)) {
        return null;
      }
      final collectionSeries = await bingeDao.getSeriesForCollection(collection.id);
      final series = selection == null
          ? collectionSeries
          : collectionSeries
                .where((s) => selection.includesSeries(collection.id, s.id))
                .toList();
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
      if (_isCancelled(isCancelled)) {
        return null;
      }
      final collectionDirName = _uniquePathSegment(
        collection.name,
        usedCollectionDirs,
        fallback: 'collection',
      );

      final usedSeriesFiles = <String>{};
      final seriesPaths = <String>[];
      final series = collectionIdVsSeries[collection.id] ?? [];

      for (final sery in series) {
        if (_isCancelled(isCancelled)) {
          return null;
        }
        final model = await bingeDao.streamBingeModel(sery.id).first;
        if (_isCancelled(isCancelled)) {
          return null;
        }
        final fileName = _uniqueFileName(
          SeryPort.buildFileName(model.title),
          usedSeriesFiles,
        );
        final relativePath = p.posix.join(collectionDirName, fileName);
        archive.addFile(ArchiveFile.bytes(relativePath, SeryPort.exportBytes(model)));

        exported++;
        seriesPaths.add(relativePath);
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
    archive.addFile(
      ArchiveFile.string(masterFileName, '${encoder.convert(masterJson)}\n'),
    );

    return ZipEncoder().encodeBytes(archive);
  }

  static bool _isCancelled(bool Function()? isCancelled) {
    return isCancelled?.call() ?? false;
  }

  static List<_LibraryCollectionManifest> _filterManifest(
    List<_LibraryCollectionManifest> manifest,
    LibraryImportSelection? selection,
  ) {
    if (selection == null) {
      return manifest;
    }

    final filtered = <_LibraryCollectionManifest>[];
    for (var i = 0; i < manifest.length; i++) {
      if (!selection.includesCollection(i)) {
        continue;
      }
      final collection = manifest[i];
      filtered.add(
        collection.copyWith(
          seriesPaths: collection.seriesPaths
              .where((path) => selection.includesSeries(i, path))
              .toList(),
        ),
      );
    }
    return filtered;
  }

  static List<_LibraryCollectionManifest> _readManifestContent(String content) {
    final json = jsonDecode(content);
    if (json is! Map<String, dynamic>) {
      throw const FormatException('Invalid library index');
    }

    final collectionsJson = json['collections'];
    if (collectionsJson is! List) {
      throw const FormatException('Invalid library collections');
    }

    final collections = <_LibraryCollectionManifest>[];
    for (final collectionJson in collectionsJson) {
      if (collectionJson is! Map<String, dynamic>) {
        throw const FormatException('Invalid library collection');
      }

      final name = collectionJson['name'];
      final description = collectionJson['description'];
      final seriesJson = collectionJson['series'];
      if (name is! String || seriesJson is! List) {
        throw const FormatException('Invalid library collection fields');
      }

      final seriesPaths = <String>[];
      for (final seriesPath in seriesJson) {
        if (seriesPath is! String) {
          throw const FormatException('Invalid library series path');
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

  static Future<bool> _importManifest(
    List<_LibraryCollectionManifest> manifest, {
    void Function(LibraryImportProgress progress)? onProgress,
    bool Function()? isCancelled,
    required Future<Uint8List> Function(String seriesPath) readSeriesBytes,
  }) async {
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

    if (_isCancelled(isCancelled)) {
      return false;
    }

    final bingeDao = BingeDao(Database());
    final existingCollections = await bingeDao.getCollectionsByPriority(isSystem: false);
    if (_isCancelled(isCancelled)) {
      return false;
    }

    final createdCollectionIds = <int>[];
    var collectionPriority = existingCollections.fold<int>(
      0,
      (maxPriority, collection) =>
          collection.priority > maxPriority ? collection.priority : maxPriority,
    );

    try {
      for (final manifestCollection in manifest) {
        if (_isCancelled(isCancelled)) {
          await _deleteImportedCollections(bingeDao, createdCollectionIds);
          return false;
        }
        final collection = await bingeDao.createCollection(
          name: manifestCollection.name,
          description: manifestCollection.description,
          isSystem: false,
          priority: ++collectionPriority,
        );
        createdCollectionIds.add(collection.id);

        var seriesPriority = 0;
        for (final seriesPath in manifestCollection.seriesPaths) {
          if (_isCancelled(isCancelled)) {
            await _deleteImportedCollections(bingeDao, createdCollectionIds);
            return false;
          }
          final data = await readSeriesBytes(seriesPath);
          if (_isCancelled(isCancelled)) {
            await _deleteImportedCollections(bingeDao, createdCollectionIds);
            return false;
          }
          final sery = await SeryPort.import(
            data,
            collectionId: collection.id,
            priority: ++seriesPriority,
          );

          imported++;
          onProgress?.call(
            LibraryImportProgress(
              imported: imported,
              total: totalSeries,
              label: sery.name,
            ),
          );
          if (_isCancelled(isCancelled)) {
            await _deleteImportedCollections(bingeDao, createdCollectionIds);
            return false;
          }
        }
      }
    } catch (_) {
      await _deleteImportedCollections(bingeDao, createdCollectionIds);
      rethrow;
    }

    return true;
  }

  static Future<void> _deleteImportedCollections(
    BingeDao bingeDao,
    List<int> collectionIds,
  ) async {
    for (final collectionId in collectionIds.reversed) {
      await bingeDao.deleteCollection(collectionId);
    }
  }

  static void _validateArchiveManifestFiles(
    Archive archive,
    List<_LibraryCollectionManifest> manifest,
  ) {
    for (final collection in manifest) {
      for (final seriesPath in collection.seriesPaths) {
        _resolveManifestArchiveFile(archive, seriesPath);
      }
    }
  }

  static ArchiveFile _resolveManifestArchiveFile(Archive archive, String manifestPath) {
    final normalized = _normalizeManifestPath(manifestPath);
    final file = archive.findFile(normalized);
    if (file == null || !file.isFile) {
      throw FormatException('Series export not found: $manifestPath');
    }
    return file;
  }

  static String _normalizeManifestPath(String manifestPath) {
    final normalized = p.posix.normalize(manifestPath);
    if (p.posix.isAbsolute(normalized) || normalized.startsWith('../')) {
      throw FormatException('Invalid library series path: $manifestPath');
    }
    return normalized;
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

  _LibraryCollectionManifest copyWith({List<String>? seriesPaths}) {
    return _LibraryCollectionManifest(
      name: name,
      description: description,
      seriesPaths: seriesPaths ?? this.seriesPaths,
    );
  }
}
