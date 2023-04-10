class NoteModel {
  late int? id;
  late String title;
  late String desc;

  NoteModel({
    this.id,
    required this.title,
    required this.desc,
  });

  // convert json into NoteModel object
  NoteModel.fromMap(Map<String, dynamic> json) {
    id = json["id"];
    desc = json["desc"];
    title = json["title"];
  }

  // convert NoteModel object into json
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["desc"] = desc;
    return _data;
  }
}
