import 'dart:developer';

import 'package:riverpod/riverpod.dart';

import '../models/config.dart';

final configsProvider = StateProvider<List<Config>>((ref) {
  return [];
});

final refreshConfigsProvider = FutureProvider<void>((ref) async {
  final configs = await Config.load();
  ref.read(configsProvider.notifier).state = configs;
});

final createConfigProvider =
    FutureProvider.autoDispose.family<Config?, Config>((ref, config) async {
  final savedConfig = await config.create();
  await ref.read(refreshConfigsProvider.future);
  return savedConfig;
});

final updateConfigProvider =
    FutureProvider.autoDispose.family<Config?, Config>((ref, config) async {
  final updatedConfig = await config.update();
  if (updatedConfig != null) {
    await ref.read(refreshConfigsProvider.future);
    return updatedConfig;
  }
  return null;
});

final deleteConfigProvider =
    FutureProvider.autoDispose.family<Config?, Config>((ref, config) async {
  log('[deleteConfigProvider] ${config.toJson()}');
  await config.delete();
  await ref.read(refreshConfigsProvider.future);
  return config;
});
