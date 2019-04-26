import 'package:json_annotation/json_annotation.dart';

part 'send_data.g.dart';

@JsonSerializable()
class SendData extends Object with _$SendDataSerializerMixin {
  String method;

  String data;

  SendData(this.method, this.data);

  factory SendData.fromJson(Map<String, dynamic> srcJson) =>
      _$SendDataFromJson(srcJson);
}
