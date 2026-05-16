import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/config/font_size.dart';
import 'package:bingetube/core/config/player_type.dart';
import 'package:bingetube/pages/page_route.dart';
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
              onPressed: () {},
              icon: const Icon(Icons.file_upload_outlined),
              label: const Text('Import library'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.file_download_outlined),
              label: const Text('Export library'),
            ),
          ),
        ],
      ),
    );
  }

  static PageGoRoute goRoute() {
    return PageGoRoute(
      page: .settings,
      transistionType: .none,
      customBuilder: (_, _) => SettingsPage(),
    );
  }
}
