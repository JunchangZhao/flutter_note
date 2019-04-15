final String dbName = "note.db";
final String tableName = "note";
final String columnId = "columnId";
final String columnTitile = "titile";
final String columnContext = "context";
final String columnCreateTime = "createTime";
final String columnModifyTime = "modifyTime";
final String columnIsDeleted = "isDeleted";

class Note {
  String title;
  String context;
  int createTime;
  int modifyTime;
  bool isDeleted;

  Note(String titile, String context, int createTime, int modifyTime) {
    this.title = titile;
    this.context = context;
    this.createTime = createTime;
    this.modifyTime = modifyTime;
    this.isDeleted = false;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitile: title,
      columnContext: context,
      columnCreateTime: createTime,
      columnModifyTime: modifyTime,
      columnIsDeleted: isDeleted
    };
    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    title = map[columnTitile];
    context = map[columnContext];
    createTime = map[columnCreateTime];
    modifyTime = map[columnModifyTime];
    isDeleted = map[columnIsDeleted] != 0;
  }
}
