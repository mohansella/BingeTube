import 'package:bingetube/core/config/configuration.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(children: [_buildTheme(context, ref)]),
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
          Expanded(
            child: Text('Theme', style: Theme.of(context).textTheme.bodyLarge),
          ),
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
}
