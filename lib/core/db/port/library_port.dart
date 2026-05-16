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

sealed class LibraryPort {
  static const masterFileName = 'library.json';
  static final _logger = LogManager.getLogger('LibraryPort');

  static Future<String?> pickExportDirectory() {
    return FilePicker.getDirectoryPath(
      dialogTitle: 'Select folder to export your library:',
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
