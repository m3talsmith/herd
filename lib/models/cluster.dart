import 'package:kuberneteslib/kuberneteslib.dart' as k8s;

class Cluster {
  final String name;
  final String server;
  final String certificateAuthorityData;

  Cluster(
      {required this.name,
      required this.server,
      required this.certificateAuthorityData});

  factory Cluster.fromJson(Map<String, dynamic> json) {
    return Cluster(
      name: json['name'],
      server: json['server'],
      certificateAuthorityData: json['certificateAuthorityData'],
    );
  }

  k8s.Cluster toK8sCluster() {
    return k8s.Cluster(
      name: name,
      server: server,
      certificateAuthorityData: certificateAuthorityData,
    );
  }
}
