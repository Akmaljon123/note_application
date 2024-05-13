import 'package:hive/hive.dart';
part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel {
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String text;
  @HiveField(2)
  String? path;

  NoteModel({
    required this.title,
    required this.text,
    this.path
  });

  NoteModel.fromJson(Map<String, Object?> json){
    title = json["title"] as String;
    text = json["text"] as String;
    path = json["path"] as String;
  }

  Map<String, Object?> toJson(){
    return {
      "title": title,
      "text": text,
      "path": path
    };
  }
}