import 'dart:io';

final files = [
  'macos/Runner.xcodeproj/project.pbxproj',
  'macos/Runner/DebugProfile.entitlements',
  'macos/Runner/Release.entitlements',
  'ios/Runner.xcodeproj/project.pbxproj',
];

void main(List<String> args) async {
  if (args.isEmpty || (args[0] != 'enable' && args[0] != 'disable')) {
    stderr.writeln('Usage: dart git_skip_worktree.dart <enable|disable>');
    exit(1);
  }

  final action = args[0] == 'enable' ? '--skip-worktree' : '--no-skip-worktree';

  for (final file in files) {
    if (!File(file).existsSync()) {
      print('Skipping (not found): $file');
      continue;
    }

    final result = await Process.run('git', ['update-index', action, file]);

    if (result.exitCode == 0) {
      print('${args[0]}: $file');
    } else {
      stderr.writeln('Failed for $file');
      stderr.writeln(result.stderr);
    }
  }
}
