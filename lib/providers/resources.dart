import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuberneteslib/kuberneteslib.dart' as k8s;

final resourcesProvider =
    AsyncNotifierProvider<ResourcesProvider, List<k8s.Resource>>(
        ResourcesProvider.new);

class ResourcesProvider extends AsyncNotifier<List<k8s.Resource>> {
  @override
  FutureOr<List<k8s.Resource>> build() {
    return [];
  }

  Future<void> refreshResources(k8s.Config config, String contextName,
      k8s.ResourceKind resourceKind) async {
    final auth = k8s.ClusterAuth.fromSelectedContext(config, contextName);
    final resources = await k8s.Resource.list(
      resourceKind: resourceKind.name,
      auth: auth,
    );
    state = AsyncValue.data(resources);
  }
}
