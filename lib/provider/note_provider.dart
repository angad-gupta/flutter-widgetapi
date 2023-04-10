import 'package:flutter/material.dart';
import 'package:projectapp/database/database_helper.dart';
import 'package:projectapp/model/note_model.dart';

// this is state class which extend change notifier

class NoteProvider extends ChangeNotifier {
  bool fetching = true;
  late List<NoteModel> data;
  int currentIndex = 0;

  NoteProvider() {
    data = [];
  }

  // initial method for get note list
  init() async {
    await DatabaseHelper.instance.db;
    getData();
  }

  // to get all note list
  getData() async {
    data = await DatabaseHelper.instance.getData();
    fetching = false;
    notifyListeners();
  }

  // to add new note
  addNote({context, required String title, required String desc}) {
    try {
      NoteModel newNote = NoteModel(
        title: title,
        desc: desc,
      );
      DatabaseHelper.instance.insertData(newNote).whenComplete(() => getData());

      Navigator.pop(context);
      notifyListeners();
    } catch (e) {
      debugPrint("$e");
    }
  }

  // to update existing note
  updateNote(
      {required int index,
      context,
      required String title,
      required String desc}) {
    currentIndex = index;
    NoteModel updateNote = data[currentIndex];
    updateNote.title = title;
    updateNote.desc = desc;
    DatabaseHelper.instance
        .update(updateNote, updateNote.id!)
        .whenComplete(() => getData());

    Navigator.pop(context);

    notifyListeners();
  }

  // to delete existing note
  deleteNote({context, required int index}) {
    DatabaseHelper.instance
        .delete(data[index].id!)
        .whenComplete(() => getData());

    Navigator.pop(context);

    notifyListeners();
  }
}
