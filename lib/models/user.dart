class User {
  final String name;
  final String clientCertificateData;
  final String clientKeyData;

  User(
      {required this.name,
      required this.clientCertificateData,
      required this.clientKeyData});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      clientCertificateData: json['clientCertificateData'],
      clientKeyData: json['clientKeyData'],
    );
  }
}
