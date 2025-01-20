import 'dart:io';
import 'package:kuberneteslib/kuberneteslib.dart'
    if (dart.io) 'package:kuberneteslib/kuberneteslib_io.dart'
    if (dart.web) 'package:kuberneteslib/kuberneteslib_web.dart';
import 'package:yaml/yaml.dart';
import 'package:humanizer/humanizer.dart';

void main() {
  const pathName = 'properties/status';
  for (final kind in ResourceKind.values) {
    final humanizedKind = SymbolName(kind.name).toHumanizedName();
    final parts = humanizedKind.split(' ');
    final kindSnakeCased = parts.map((e) => e.toLowerCase()).join('_');
    final filename = '$pathName/$kindSnakeCased.yaml';
    final file = File(filename);
    final content = loadYaml(file.readAsStringSync());
    print(content);
  }
}
