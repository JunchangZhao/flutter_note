import 'package:json_annotation/json_annotation.dart';

part 'register_result.g.dart';


@JsonSerializable()
class RegisterResult extends Object with _$RegisterResultSerializerMixin{

  @JsonKey(name: 'isSuccess')
  bool isSuccess;

  @JsonKey(name: 'data')
  Data data;

  RegisterResult(this.isSuccess,this.data,);

  factory RegisterResult.fromJson(Map<String, dynamic> srcJson) => _$RegisterResultFromJson(srcJson);

}


@JsonSerializable()
class Data extends Object with _$DataSerializerMixin{

  @JsonKey(name: 'isSuccess')
  bool isSuccess;

  @JsonKey(name: 'isAccountValid')
  bool isAccountValid;

  @JsonKey(name: 'isAccountNotDuplicate')
  bool isAccountNotDuplicate;

  @JsonKey(name: 'isPasswdValid')
  bool isPasswdValid;

  Data(this.isSuccess,this.isAccountValid,this.isAccountNotDuplicate,this.isPasswdValid,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

}


