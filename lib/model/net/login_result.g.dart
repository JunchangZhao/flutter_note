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
          : new Data.fromJson(json['data'] as Map<String, dynamic>));
}

abstract class _$LoginResultSerializerMixin {
  bool get isSuccess;
  Data get data;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'isSuccess': isSuccess, 'data': data};
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return new Data(json['isSuccess'] as bool);
}

abstract class _$DataSerializerMixin {
  bool get isSuccess;
  Map<String, dynamic> toJson() => <String, dynamic>{'isSuccess': isSuccess};
}
