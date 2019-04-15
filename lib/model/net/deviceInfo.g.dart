// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deviceInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllDeviceInfo _$AllDeviceInfoFromJson(Map<String, dynamic> json) {
  return new AllDeviceInfo(
      json['isSuceess'] as bool,
      (json['resultData'] as List)
          ?.map((e) => e == null
              ? null
              : new ResultData.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

abstract class _$AllDeviceInfoSerializerMixin {
  bool get isSuceess;
  List<ResultData> get resultData;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'isSuceess': isSuceess, 'resultData': resultData};
}

ResultData _$ResultDataFromJson(Map<String, dynamic> json) {
  return new ResultData(json['blockApps'] as List, json['blockService'] as List,
      json['deviceId'] as String);
}

abstract class _$ResultDataSerializerMixin {
  List<dynamic> get blockApps;
  List<dynamic> get blockService;
  String get deviceId;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'blockApps': blockApps,
        'blockService': blockService,
        'deviceId': deviceId
      };
}
