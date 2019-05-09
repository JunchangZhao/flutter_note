// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteInfo _$NoteInfoFromJson(Map<String, dynamic> json) {
  return new NoteInfo(json['title'] as String, json['context'] as String,
      json['createTime'] as int, json['modifyTime'] as int);
}

abstract class _$NoteInfoSerializerMixin {
  int get createTime;
  int get modifyTime;
  String get context;
  String get title;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'createTime': createTime,
        'modifyTime': modifyTime,
        'context': context,
        'title': title
      };
}

NotesCreateAndModifyInfo _$NotesCreateAndModifyInfoFromJson(
    Map<String, dynamic> json) {
  return new NotesCreateAndModifyInfo(
      json['type'] as String,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : new NoteInfo.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

abstract class _$NotesCreateAndModifyInfoSerializerMixin {
  String get type;
  List<NoteInfo> get data;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'type': type, 'data': data};
}
