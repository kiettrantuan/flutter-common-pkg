import 'dart:convert';

abstract class Model {
  const Model();

  factory Model.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('fromJson must be implemented in subclasses');
  }

  Map<String, dynamic> toJson();

  String toJsonString() => toJson().toString();

  static T fromJsonString<T extends Model>(
      String jsonString, T Function(Map<String, dynamic>) fromJson) {
    return fromJson(jsonDecode(jsonString));
  }
}
