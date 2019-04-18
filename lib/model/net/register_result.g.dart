// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResult _$RegisterResultFromJson(Map<String, dynamic> json) {
  return new RegisterResult(
      json['isSuccess'] as bool,
      json['data'] == null
          ? null
          : new Data.fromJson(json['data'] as Map<String, dynamic>));
}

abstract class _$RegisterResultSerializerMixin {
  bool get isSuccess;
  Data get data;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'isSuccess': isSuccess, 'data': data};
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return new Data(json['isSuccess'] as bool, json['isAccountValid'] as bool,
      json['isAccountNotDuplicate'] as bool, json['isPasswdValid'] as bool);
}

abstract class _$DataSerializerMixin {
  bool get isSuccess;
  bool get isAccountValid;
  bool get isAccountNotDuplicate;
  bool get isPasswdValid;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'isSuccess': isSuccess,
        'isAccountValid': isAccountValid,
        'isAccountNotDuplicate': isAccountNotDuplicate,
        'isPasswdValid': isPasswdValid
      };
}
