import 'dart:developer';

import 'package:flutter/material.dart';
import '../storage/storage.dart';

import 'window.dart';

enum WindowPreferenceKey {
  fullscreen,
  windowSize,
  windowPosition,
  currentConfigIndex,
  currentContextIndex,
}

class WindowPreferences {
  bool _fullscreen = false;
  Size? _windowSize;
  WindowPosition? _windowPosition;

  void refresh() {
    final preferences = Storage.loadWindowPreferences();
    _fullscreen = preferences?.fullscreen ?? false;
    _windowSize = preferences?.windowSize;
    _windowPosition = preferences?.windowPosition;
  }

  Map<String, dynamic> toJson() {
    final size = {
      'height': _windowSize?.height,
      'width': _windowSize?.width,
    };
    return {
      'fullscreen': _fullscreen,
      'windowSize': size,
      'windowPosition': _windowPosition?.toJson(),
    };
  }

  static WindowPreferences fromJson(Map<String, dynamic> json) {
    return WindowPreferences()
      ..fullscreen = json['fullscreen']
      ..windowSize = json['windowSize'] != null
          ? Size(json['windowSize']['width'], json['windowSize']['height'])
          : Size(0, 0)
      ..windowPosition = json['windowPosition'] != null
          ? WindowPosition.fromJson(json['windowPosition'])
          : WindowPosition();
  }

  bool get fullscreen => _fullscreen;
  set fullscreen(bool value) {
    _fullscreen = value;
    Storage.saveWindowPreferences(this);
  }

  Size? get windowSize => _windowSize;
  set windowSize(Size? value) {
    if (value == null) return;

    _windowSize = value;
    Storage.saveWindowPreferences(this);
  }

  WindowPosition? get windowPosition => _windowPosition;
  set windowPosition(WindowPosition? value) {
    if (value == null) return;

    _windowPosition = value;
    Storage.saveWindowPreferences(this);
  }
}
