// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'content': instance.content,
    };
