import 'package:json_annotation/json_annotation.dart';

part 'package:flutter_app/model/data/net/restful/login_result.g.dart';


@JsonSerializable()
class LoginResult extends Object with _$LoginResultSerializerMixin{

  bool isSuccess;

  Data data;

  String msg;

  LoginResult(this.isSuccess,this.data,this.msg,);

  factory LoginResult.fromJson(Map<String, dynamic> srcJson) => _$LoginResultFromJson(srcJson);

}


@JsonSerializable()
class Data extends Object with _$DataSerializerMixin{

  bool isSuccess;

  String jwt;

  Data(this.isSuccess,this.jwt,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

}


