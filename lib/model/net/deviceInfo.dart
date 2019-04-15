import 'package:json_annotation/json_annotation.dart';

part 'package:flutter_app/model/net/deviceInfo.g.dart';


@JsonSerializable()
class AllDeviceInfo extends Object with _$AllDeviceInfoSerializerMixin{

  @JsonKey(name: 'isSuceess')
  bool isSuceess;

  @JsonKey(name: 'resultData')
  List<ResultData> resultData;

  AllDeviceInfo(this.isSuceess,this.resultData,);

  factory AllDeviceInfo.fromJson(Map<String, dynamic> srcJson) => _$AllDeviceInfoFromJson(srcJson);

}


@JsonSerializable()
class ResultData extends Object with _$ResultDataSerializerMixin{

  @JsonKey(name: 'blockApps')
  List<dynamic> blockApps;

  @JsonKey(name: 'blockService')
  List<dynamic> blockService;

  @JsonKey(name: 'deviceId')
  String deviceId;

  ResultData(this.blockApps,this.blockService,this.deviceId,);

  factory ResultData.fromJson(Map<String, dynamic> srcJson) => _$ResultDataFromJson(srcJson);

}


