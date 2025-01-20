import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/config.dart';

final configsProvider =
    AutoDisposeAsyncNotifierProvider<ConfigsProvider, List<Config>>(
        ConfigsProvider.new);

class ConfigsProvider extends AutoDisposeAsyncNotifier<List<Config>> {
  @override
  Future<List<Config>> build() async {
    return Config.findAll();
  }

  Future<List<Config>> refresh() async {
    state = AsyncValue.data(Config.findAll());
    return state.valueOrNull ?? [];
  }

  Future<Config?> createConfig(Config config) async {
    final savedConfig = await config.create();
    if (savedConfig != null) {
      await refresh();
    }
    return savedConfig;
  }

  Future<Config?> updateConfig(Config config) async {
    final updatedConfig = await config.update();
    if (updatedConfig != null) {
      await refresh();
    }
    return updatedConfig;
  }

  Future<Config?> deleteConfig(Config config) async {
    await config.delete();
    await refresh();
    return config;
  }
}
