import 'package:json_annotation/json_annotation.dart';

part 'notes_create_modify.g.dart';

@JsonSerializable()
class NoteInfo extends Object with _$DataSerializerMixin {
  @JsonKey(name: 'createTime')
  int createTime;

  @JsonKey(name: 'modifyTime')
  int modifyTime;

  @JsonKey(name: 'context')
  String context;

  @JsonKey(name: 'title')
  int title;

  NoteInfo(
    this.createTime,
    this.modifyTime,
  );

  factory NoteInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);
}

@JsonSerializable()
class NotesCreateAndModifyInfo extends Object
    with _$NotesCreateAndModifyInfoSerializerMixin {
  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'data')
  List<NoteInfo> data;

  NotesCreateAndModifyInfo(
    this.type,
    this.data,
  );

  factory NotesCreateAndModifyInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$NotesCreateAndModifyInfoFromJson(srcJson);
}
