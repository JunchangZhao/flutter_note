// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendData _$SendDataFromJson(Map<String, dynamic> json) {
  return new SendData(json['method'] as String, json['data'] as String);
}

abstract class _$SendDataSerializerMixin {
  String get method;
  String get data;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'method': method, 'data': data};
}
