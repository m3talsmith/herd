import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'window_preferences.dart';

class Window {
  Window();

  late WindowPreferences _preferences;

  WindowPreferences get preferences => _preferences;
  bool get fullscreen => _preferences.fullscreen;
  Size? get size => _preferences.windowSize;
  WindowPosition? get position => _preferences.windowPosition;

  ensureInitialized() async {
    _preferences = WindowPreferences();
    await windowManager.ensureInitialized();

    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      var windowOptions = WindowOptions(
        fullScreen: fullscreen,
        size: size,
        center: (position == null),
      );

      windowManager.waitUntilReadyToShow(windowOptions, () async {
        if (position != null) {
          await windowManager.setPosition(position!.offset);
        }
        await windowManager.show();
        await windowManager.focus();
      });
    }
  }
}

class WindowPosition {
  WindowPosition({
    this.left,
    this.right,
    this.top,
    this.bottom,
    this.center,
  });

  double? left;
  double? right;
  double? top;
  double? bottom;
  double? center;

  Offset get offset => Offset(top ?? 0, left ?? 0);

  Map<String, dynamic> toJson() {
    return {
      'top': top,
      'left': left,
      'right': right,
      'bottom': bottom,
      'center': center,
    };
  }

  static WindowPosition fromJson(Map<String, dynamic> json) {
    return WindowPosition()
      ..top = json['top']
      ..left = json['left']
      ..right = json['right']
      ..bottom = json['bottom']
      ..center = json['center'];
  }
}
