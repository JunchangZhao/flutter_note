// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) {
  return new LoginResult(
      json['isSuccess'] as bool,
      json['data'] == null
          ? null
          : new Data.fromJson(json['data'] as Map<String, dynamic>),
      json['msg'] as String);
}

abstract class _$LoginResultSerializerMixin {
  bool get isSuccess;
  Data get data;
  String get msg;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'isSuccess': isSuccess, 'data': data, 'msg': msg};
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return new Data(json['isSuccess'] as bool, json['jwt'] as String);
}

abstract class _$DataSerializerMixin {
  bool get isSuccess;
  String get jwt;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'isSuccess': isSuccess, 'jwt': jwt};
}
