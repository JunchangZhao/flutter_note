import 'package:json_annotation/json_annotation.dart';

part 'notes_info.g.dart';

@JsonSerializable()
class NoteInfo extends Object with _$NoteInfoSerializerMixin {
  @JsonKey(name: 'createTime')
  int createTime;

  @JsonKey(name: 'modifyTime')
  int modifyTime;

  @JsonKey(name: 'context')
  String context;

  @JsonKey(name: 'title')
  String title;

  NoteInfo(
    this.title,
    this.context,
    this.createTime,
    this.modifyTime,
  );

  factory NoteInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$NoteInfoFromJson(srcJson);
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
