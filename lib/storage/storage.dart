import 'dart:convert';
import 'dart:developer';

import 'package:herd/models/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/window_preferences.dart';

enum StorageKey {
  configs,
  windowPreferences,
}

class Storage {
  static SharedPreferences? data;
  static List<Config> configs = [];

  static Future<void> ensureInitialized() async {
    data ??= await SharedPreferences.getInstance();
  }

  static Future<void> saveConfigs() async {
    final savingConfigs = configs.map((c) => c.toJson()).toList();
    await data?.setString(StorageKey.configs.name, jsonEncode(savingConfigs));
  }

  static Future<void> saveConfig(Config config) async {
    configs.add(config);
    await saveConfigs();
  }

  static void loadConfigs() {
    Storage.configs.clear();
    final configs = data?.getString(StorageKey.configs.name);
    if (configs != null) {
      for (var config in jsonDecode(configs)) {
        Storage.configs.add(Config.fromJson(config));
      }
    }
  }

  static Future<void> deleteConfig(Config config) async {
    configs.remove(config);
    await saveConfigs();
  }

  static Future<void> saveWindowPreferences(
      WindowPreferences preferences) async {
    await data?.setString(
        StorageKey.windowPreferences.name, jsonEncode(preferences.toJson()));
  }

  static WindowPreferences? loadWindowPreferences() {
    final preferences = data?.getString(StorageKey.windowPreferences.name);
    if (preferences != null) {
      final windowPreferences =
          WindowPreferences.fromJson(jsonDecode(preferences));
      return windowPreferences;
    }
    return null;
  }
}
