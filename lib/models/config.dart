import 'dart:developer';

import '../storage/storage.dart';
import 'cluster.dart';
import 'context.dart';
import 'user.dart';
import 'status.dart';

import 'package:json_annotation/json_annotation.dart' as json_annotation;
import 'package:kuberneteslib/kuberneteslib.dart' as k8s;
import 'package:uuid/uuid.dart';
import 'package:yaml/yaml.dart' as yamlParser;

part 'config.g.dart';

@json_annotation.JsonSerializable()
class Config {
  @json_annotation.JsonKey(includeIfNull: false)
  String? id;

  @json_annotation.JsonKey(includeIfNull: false)
  String? name;

  @json_annotation.JsonKey(includeIfNull: false)
  String? description;

  @json_annotation.JsonKey(includeIfNull: false)
  String? content;

  @json_annotation.JsonKey(includeFromJson: false, includeToJson: false)
  List<Cluster> clusters = [];

  @json_annotation.JsonKey(includeFromJson: false, includeToJson: false)
  List<ConfigContext> contexts = [];

  @json_annotation.JsonKey(includeFromJson: false, includeToJson: false)
  List<User> users = [];

  @json_annotation.JsonKey(includeFromJson: false, includeToJson: false)
  String? currentContext;

  Config({this.id, this.name, this.description, this.content}) {
    parseContent();
  }

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigToJson(this);

  static List<Config> findAll() {
    final configs = Storage.configs;
    configs.sort((a, b) => a.name!.compareTo(b.name!));
    configs.forEach((config) {
      config.parseContent();
    });
    return configs;
  }

  static Config? findById(String id) {
    Config? config;
    for (var c in Storage.configs) {
      if (c.id == id) {
        config = c;
        break;
      }
    }
    return config;
  }

  Future<Config?> create() async {
    final id = const Uuid().v4();
    Storage.configs.add(
        Config(id: id, name: name, description: description, content: content));
    await Storage.saveConfigs();

    return findById(id);
  }

  Future<Config?> update() async {
    if (id == null) return null;

    Storage.configs.removeWhere((e) => e.id == id);
    Storage.configs.add(
        Config(id: id, name: name, description: description, content: content));
    await Storage.saveConfigs();

    return findById(id!);
  }

  Future<void> delete() async {
    Storage.configs.removeWhere((e) => e.id == id);
    await Storage.saveConfigs();
  }

  get selectedContext => contexts.firstWhere((e) => e.name == currentContext);

  parseContent() {
    final data = yamlParser.loadYaml(content!);

    final localClusters = <Cluster>[];
    final localContexts = <ConfigContext>[];
    final localUsers = <User>[];
    for (var cluster in data['clusters']) {
      final clusterMap = yamlToMap(cluster);
      final clusterData = <String, dynamic>{};
      clusterData['name'] = clusterMap['name'] ?? '';
      clusterData['server'] = clusterMap['cluster']['server'] ?? '';
      clusterData['certificateAuthorityData'] =
          clusterMap['cluster']['certificate-authority-data'] ?? '';
      localClusters.add(Cluster.fromJson(clusterData));
    }
    for (var context in data['contexts']) {
      final contextMap = yamlToMap(context);
      final contextData = <String, dynamic>{};
      contextData['name'] = contextMap['name'] ?? '';
      contextData['cluster'] = contextMap['context']['cluster'] ?? '';
      contextData['user'] = contextMap['context']['user'] ?? '';
      localContexts.add(ConfigContext.fromJson(contextData));
    }
    for (var user in data['users']) {
      final userMap = yamlToMap(user);
      final userData = <String, dynamic>{};
      userData['name'] = userMap['name'] ?? '';
      userData['clientCertificateData'] =
          userMap['user']['client-certificate-data'] ?? '';
      userData['clientKeyData'] = userMap['user']['client-key-data'] ?? '';
      localUsers.add(User.fromJson(userData));
    }
    currentContext = data['current-context'] ?? '';

    clusters = localClusters;
    contexts = localContexts;
    users = localUsers;
  }

  Future<List<Status>> getStatuses() async {
    final statuses = <Status>[];
    for (var context in contexts) {
      final k8sconfig = toK8sConfig();

      final auth = k8s.ClusterAuth.fromConfig(k8sconfig);
      final url = Uri.parse(
          clusters.firstWhere((e) => e.name == context.clusterName).server);
      log('[Config] getStatuses url: $url');
      // final response = await auth.get(url);
      // log('[Config] getStatuses response: ${response.body}');
      // final status = Status(name: context.name, status: response.body);
      // statuses.add(status);
    }
    return statuses;
  }

  k8s.Config toK8sConfig() {
    return k8s.Config(
      clusters: clusters
          .map((e) => k8s.Cluster(
              name: e.name,
              server: e.server,
              certificateAuthorityData: e.certificateAuthorityData))
          .toList(),
      users: users
          .map((e) => k8s.User(
              name: e.name,
              clientCertificateData: e.clientCertificateData,
              clientKeyData: e.clientKeyData))
          .toList(),
      contexts: contexts
          .map((e) => k8s.Context(
              name: e.name, cluster: e.clusterName, user: e.userName))
          .toList(),
    );
  }

  static Map<String, dynamic> yamlToMap(yamlParser.YamlMap yaml) {
    final map = <String, dynamic>{};
    for (var entry in yaml.entries) {
      if (entry.value is yamlParser.YamlMap) {
        map[entry.key.toString()] = yamlToMap(entry.value);
      } else if (entry.value is yamlParser.YamlList) {
        map[entry.key.toString()] = yamlListToList(entry.value);
      } else {
        map[entry.key.toString()] = entry.value;
      }
    }
    return map;
  }

  static List<dynamic> yamlListToList(yamlParser.YamlList yamlList) {
    return yamlList.map((item) {
      if (item is yamlParser.YamlMap) {
        return yamlToMap(item);
      } else if (item is yamlParser.YamlList) {
        return yamlListToList(item);
      }
      return item;
    }).toList();
  }

  User userByName(String name) {
    return users.firstWhere((e) => e.name == name);
  }

  Cluster clusterByName(String name) {
    return clusters.firstWhere((e) => e.name == name);
  }

  ConfigContext contextByName(String name) {
    return contexts.firstWhere((e) => e.name == name);
  }
}
