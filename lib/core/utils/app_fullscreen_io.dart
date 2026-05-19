import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

const _methodChannel = MethodChannel('bingetube/fullscreen');
const _eventChannel = EventChannel('bingetube/fullscreen_events');

bool _isFullscreen = false;
Stream<bool>? _fullscreenChanges;

Stream<bool> get fullscreenChanges {
  if (!Platform.isMacOS) {
    return const Stream.empty();
  }
  return _fullscreenChanges ??= _eventChannel.receiveBroadcastStream().map((event) {
    final isFullscreen = event == true;
    _isFullscreen = isFullscreen;
    return isFullscreen;
  });
}

bool get isFullscreen => _isFullscreen;

Future<void> enterFullscreen() async {
  if (!Platform.isMacOS || _isFullscreen) {
    return;
  }

  try {
    _isFullscreen = await _methodChannel.invokeMethod<bool>('enterFullscreen') ?? true;
  } on MissingPluginException {
    _isFullscreen = false;
  }
}

Future<void> exitFullscreen() async {
  if (!Platform.isMacOS || !_isFullscreen) {
    return;
  }

  try {
    _isFullscreen = await _methodChannel.invokeMethod<bool>('exitFullscreen') ?? false;
  } on MissingPluginException {
    _isFullscreen = false;
  }
}
