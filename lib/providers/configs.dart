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
  if (savedConfig != null) {
    await ref.read(refreshConfigsProvider.future);
    return savedConfig;
  }
  return null;
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
