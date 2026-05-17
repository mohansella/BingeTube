import 'package:bingetube/common/widget/custom_dialog.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/config/font_size.dart';
import 'package:bingetube/core/config/player_type.dart';
import 'package:bingetube/core/db/port/library_port.dart';
import 'package:bingetube/pages/page_route.dart';
import 'package:bingetube/pages/settings/widgets/library_tree_selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionHeader(context, 'Preferences'),
                _buildTheme(context, ref),
                _buildFontSize(context, ref),
                _buildPlayerType(context, ref),
                const Divider(height: 32),
                _buildSectionHeader(context, 'Library data'),
                _buildDataActions(context),
                _buildVersionInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVersionInfo() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FutureBuilder(
          future: PackageInfo.fromPlatform(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              final info = snapshot.data!;
              return Text('Version: ${info.version} Build: ${info.buildNumber}');
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Text(title, style: Theme.of(context).textTheme.titleSmall),
    );
  }

  Container _buildTheme(BuildContext context, WidgetRef ref) {
    var selectedThemeMode = ref.watch(ConfigProviders.theme);
    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.color_lens_outlined, size: 24),
          SizedBox(width: 8),
          Expanded(child: Text('Theme', style: Theme.of(context).textTheme.bodyLarge)),
          SegmentedButton(
            segments: ThemeMode.values
                .map(
                  (v) => ButtonSegment(
                    label: Text(v.name[0].toUpperCase() + v.name.substring(1)),
                    value: v,
                  ),
                )
                .toList(),
            selected: {selectedThemeMode},
            onSelectionChanged: (s) {
              ref.read(ConfigProviders.theme.notifier).save(s.first);
            },
            showSelectedIcon: false,
          ),
        ],
      ),
    );
  }

  Container _buildFontSize(BuildContext context, WidgetRef ref) {
    var appFontSize = ref.watch(ConfigProviders.appFontSize);
    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.text_fields, size: 24),
          SizedBox(width: 8),
          Expanded(
            child: Text('Font Size', style: Theme.of(context).textTheme.bodyLarge),
          ),
          SegmentedButton(
            segments: AppFontSize.values
                .map(
                  (v) => ButtonSegment(
                    label: Text(v.name[0].toUpperCase() + v.name.substring(1)),
                    value: v,
                  ),
                )
                .toList(),
            selected: {appFontSize},
            onSelectionChanged: (s) {
              ref.read(ConfigProviders.appFontSize.notifier).save(s.first);
            },
            showSelectedIcon: false,
          ),
        ],
      ),
    );
  }

  Container _buildPlayerType(BuildContext context, WidgetRef ref) {
    var playerType = ref.watch(ConfigProviders.playerType);
    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.ondemand_video, size: 24),
          SizedBox(width: 8),
          Expanded(child: Text('Player', style: Theme.of(context).textTheme.bodyLarge)),
          SegmentedButton(
            segments: PlayerType.values
                .map(
                  (v) => ButtonSegment(
                    label: Text(v.name[0].toUpperCase() + v.name.substring(1)),
                    value: v,
                  ),
                )
                .toList(),
            selected: {playerType},
            onSelectionChanged: (s) {
              ref.read(ConfigProviders.playerType.notifier).save(s.first);
            },
            showSelectedIcon: false,
          ),
        ],
      ),
    );
  }

  Widget _buildDataActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _onImportLibrary(context),
              icon: const Icon(Icons.file_upload_outlined),
              label: const Text('Import library'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton.icon(
              onPressed: () => _onExportLibrary(context),
              icon: const Icon(Icons.file_download_outlined),
              label: const Text('Export library'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onImportLibrary(BuildContext context) async {
    final archive = await LibraryPort.pickImportArchive();
    if (archive == null) {
      return;
    }

    if (!context.mounted) {
      return;
    }

    try {
      final preview = await LibraryPort.previewImport(archive);
      if (!context.mounted) {
        return;
      }
      final treeSelection = await _showImportSelection(context, preview);
      if (treeSelection == null || treeSelection.isEmpty) {
        return;
      }
      if (!context.mounted) {
        return;
      }
      await _waitForOverlayFrame();
      if (!context.mounted) {
        return;
      }
      final importLabel = await _showImportProgress(
        context,
        archive,
        _buildImportSelection(treeSelection),
      );
      if (importLabel == null) {
        return;
      }
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Library imported from $importLabel')));
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      CustomDialog.show(context, 'Import failed', 'Okay', Text('$error'));
    }
  }

  Future<void> _onExportLibrary(BuildContext context) async {
    if (!context.mounted) {
      return;
    }

    try {
      final preview = await LibraryPort.getExportPreview();
      if (!context.mounted) {
        return;
      }
      final treeSelection = await _showExportSelection(context, preview);
      if (treeSelection == null || treeSelection.isEmpty) {
        return;
      }
      if (!context.mounted) {
        return;
      }
      await _waitForOverlayFrame();
      if (!context.mounted) {
        return;
      }
      final exportLabel = await _showExportProgress(
        context,
        _buildExportSelection(treeSelection),
      );
      if (exportLabel == null) {
        return;
      }
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Library exported to $exportLabel')));
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      CustomDialog.show(context, 'Export failed', 'Okay', Text('$error'));
    }
  }

  Future<LibraryTreeSelection?> _showImportSelection(
    BuildContext context,
    LibraryImportPreview preview,
  ) async {
    await _waitForOverlayFrame();
    if (!context.mounted) {
      return null;
    }
    return LibraryTreeSelectionSheet.show(
      context,
      title: 'Select items to import',
      actionLabel: 'Import selected',
      collections: preview.collections.map((collection) {
        return LibraryTreeCollection(
          id: '${collection.index}',
          title: collection.name,
          subtitle: '${collection.series.length} series',
          series: collection.series
              .map((series) => LibraryTreeSeries(id: series.path, title: series.title))
              .toList(),
        );
      }).toList(),
    );
  }

  Future<LibraryTreeSelection?> _showExportSelection(
    BuildContext context,
    LibraryExportPreview preview,
  ) async {
    await _waitForOverlayFrame();
    if (!context.mounted) {
      return null;
    }
    return LibraryTreeSelectionSheet.show(
      context,
      title: 'Select items to export',
      actionLabel: 'Export selected',
      collections: preview.collections.map((collection) {
        return LibraryTreeCollection(
          id: '${collection.collection.id}',
          title: collection.collection.name,
          subtitle: '${collection.series.length} series',
          series: collection.series
              .map((series) => LibraryTreeSeries(id: '${series.id}', title: series.name))
              .toList(),
        );
      }).toList(),
    );
  }

  LibraryImportSelection _buildImportSelection(LibraryTreeSelection selection) {
    return LibraryImportSelection({
      for (final entry in selection.collectionIdVsSeriesIds.entries)
        int.parse(entry.key): entry.value,
    });
  }

  LibraryExportSelection _buildExportSelection(LibraryTreeSelection selection) {
    return LibraryExportSelection({
      for (final entry in selection.collectionIdVsSeriesIds.entries)
        int.parse(entry.key): entry.value.map(int.parse).toSet(),
    });
  }

  Future<void> _waitForOverlayFrame() async {
    await Future<void>.delayed(Duration.zero);
    await WidgetsBinding.instance.endOfFrame;
  }

  Future<String?> _showImportProgress(
    BuildContext context,
    LibraryImportArchive archive,
    LibraryImportSelection selection,
  ) async {
    final progressNotifier = ValueNotifier(
      const LibraryImportProgress(imported: 0, total: 1, label: 'Reading library index'),
    );
    var cancelRequested = false;
    final importFuture = LibraryPort.importAll(
      archive,
      selection: selection,
      onProgress: (progress) {
        progressNotifier.value = progress;
      },
      isCancelled: () => cancelRequested,
    );

    try {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return FutureBuilder(
            future: importFuture,
            builder: (futureContext, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  futureContext.mounted) {
                Future.microtask(() {
                  if (futureContext.mounted) {
                    Navigator.of(futureContext).pop();
                  }
                });
              }

              return AlertDialog(
                title: const Text('Importing library'),
                content: ValueListenableBuilder(
                  valueListenable: progressNotifier,
                  builder: (_, progress, _) {
                    final hasSeries = progress.total > 0;
                    final progressValue = hasSeries
                        ? progress.imported / progress.total
                        : null;
                    final progressText = hasSeries
                        ? '${progress.imported}/${progress.total} imported'
                        : 'No series to import';

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(progressText),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(value: progressValue),
                        if (progress.label.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(progress.label),
                        ],
                      ],
                    );
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      cancelRequested = true;
                      Navigator.of(dialogContext).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
      );
      return await importFuture;
    } finally {
      progressNotifier.dispose();
    }
  }

  Future<String?> _showExportProgress(
    BuildContext context,
    LibraryExportSelection selection,
  ) async {
    final progressNotifier = ValueNotifier(
      const LibraryExportProgress(
        exported: 0,
        total: 1,
        label: 'Preparing library export',
      ),
    );
    var cancelRequested = false;
    final exportFuture = LibraryPort.exportAll(
      selection: selection,
      onProgress: (progress) {
        progressNotifier.value = progress;
      },
      isCancelled: () => cancelRequested,
    );

    try {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return FutureBuilder(
            future: exportFuture,
            builder: (futureContext, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  futureContext.mounted) {
                Future.microtask(() {
                  if (futureContext.mounted) {
                    Navigator.of(futureContext).pop();
                  }
                });
              }

              return AlertDialog(
                title: const Text('Exporting library'),
                content: ValueListenableBuilder(
                  valueListenable: progressNotifier,
                  builder: (_, progress, _) {
                    final hasSeries = progress.total > 0;
                    final progressValue = hasSeries
                        ? progress.exported / progress.total
                        : null;
                    final progressText = hasSeries
                        ? '${progress.exported}/${progress.total} exported'
                        : 'No series to export';

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(progressText),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(value: progressValue),
                        if (progress.label.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(progress.label),
                        ],
                      ],
                    );
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      cancelRequested = true;
                      Navigator.of(dialogContext).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
      );
      return await exportFuture;
    } finally {
      progressNotifier.dispose();
    }
  }

  static PageGoRoute goRoute() {
    return PageGoRoute(
      page: .settings,
      transistionType: .none,
      customBuilder: (_, _) => SettingsPage(),
    );
  }
}
