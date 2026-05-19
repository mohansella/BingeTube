import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

Stream<bool> get fullscreenChanges {
  final element = web.document.documentElement;
  return element?.onFullscreenChange.map((_) => isFullscreen) ?? const Stream.empty();
}

bool get isFullscreen => web.document.fullscreenElement != null;

Future<void> enterFullscreen() async {
  final element = web.document.documentElement;
  if (element == null || isFullscreen) {
    return;
  }

  try {
    await element.requestFullscreen().toDart;
  } catch (_) {
    // Browsers may deny fullscreen outside a trusted user gesture.
  }
}

Future<void> exitFullscreen() async {
  if (!isFullscreen) {
    return;
  }

  try {
    await web.document.exitFullscreen().toDart;
  } catch (_) {}
}
