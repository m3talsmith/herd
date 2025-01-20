import 'package:herd/models/config.dart';

class Auth {
  static Future<void> authenticate(Config config) async {
    final cert = config.content;
    final key = config.content;
  }
}
