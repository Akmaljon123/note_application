import 'package:hive/hive.dart';
import 'package:note_application/models/note_model.dart';

class HiveService{

  static Future<void> saveData({required NoteModel noteModel})async{
    final box = await Hive.openBox("note");
    box.add(noteModel);
  }

  static Future<void> editData({required NoteModel noteModel,required int index})async{
    final box = await Hive.openBox("note");
    box.putAt(index, noteModel);
  }

  static Future<List<NoteModel>> getData()async{
    final box = await Hive.openBox("note");
    return box.values.toList().cast<NoteModel>();
  }

  static Future<void> deleteData(int index)async{
    final box = await Hive.openBox("note");
    box.deleteAt(index);
  }

}