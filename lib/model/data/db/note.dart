final String dbName = "note.db";
final String tableName = "note";
final String columnId = "columnId";
final String columnTitile = "titile";
final String columnContext = "context";
final String columnCreateTime = "createTime";
final String columnModifyTime = "modifyTime";
final String columnIsDeleted = "isDeleted";
final String columnUser = "user";

class Note {
  String title;
  String context;
  int createTime;
  int modifyTime;
  bool isDeleted;
  String user;

  Note(String titile, String context, int createTime, int modifyTime,
      String user) {
    this.title = titile;
    this.context = context;
    this.createTime = createTime;
    this.modifyTime = modifyTime;
    this.isDeleted = false;
    this.user = user;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitile: title,
      columnContext: context,
      columnCreateTime: createTime,
      columnModifyTime: modifyTime,
      columnIsDeleted: isDeleted,
      columnUser: user
    };
    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    title = map[columnTitile];
    context = map[columnContext];
    createTime = map[columnCreateTime];
    modifyTime = map[columnModifyTime];
    isDeleted = map[columnIsDeleted] != 0;
    user = map[columnUser];
  }
}
