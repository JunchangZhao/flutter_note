import 'package:json_annotation/json_annotation.dart';

part 'login_result.g.dart';


@JsonSerializable()
class LoginResult extends Object with _$LoginResultSerializerMixin{

  @JsonKey(name: 'isSuccess')
  bool isSuccess;

  @JsonKey(name: 'data')
  Data data;

  LoginResult(this.isSuccess,this.data,);

  factory LoginResult.fromJson(Map<String, dynamic> srcJson) => _$LoginResultFromJson(srcJson);

}


@JsonSerializable()
class Data extends Object with _$DataSerializerMixin{

  @JsonKey(name: 'isSuccess')
  bool isSuccess;

  Data(this.isSuccess,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

}


