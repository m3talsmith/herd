class ConfigContext {
  final String name;
  final String clusterName;
  final String userName;

  ConfigContext(
      {required this.name, required this.clusterName, required this.userName});

  factory ConfigContext.fromJson(Map<String, dynamic> json) {
    return ConfigContext(
      name: json['name'],
      clusterName: json['cluster'],
      userName: json['user'],
    );
  }
}
