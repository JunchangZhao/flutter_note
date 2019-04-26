import 'package:json_annotation/json_annotation.dart';

part 'package:flutter_app/model/data/net/restful/register_result.g.dart';


@JsonSerializable()
class RegisterResult extends Object with _$RegisterResultSerializerMixin{

  bool isSuccess;

  Data data;

  String msg;

  RegisterResult(this.isSuccess,this.data,this.msg,);

  factory RegisterResult.fromJson(Map<String, dynamic> srcJson) => _$RegisterResultFromJson(srcJson);

}


@JsonSerializable()
class Data extends Object with _$DataSerializerMixin{

  bool isSuccess;

  bool isAccountValid;

  bool isAccountNotDuplicate;

  bool isPasswdValid;

  Data(this.isSuccess,this.isAccountValid,this.isAccountNotDuplicate,this.isPasswdValid,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

}


