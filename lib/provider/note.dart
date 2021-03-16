import 'package:flutter/material.dart';
import 'package:note_app/database/db_helper.dart';
import 'package:note_app/model/note_model.dart';

class Note extends ChangeNotifier {
  final noteController = TextEditingController(text: "");
  final titleController = TextEditingController(text: "");
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  GlobalKey<ScaffoldState>homeScaffoldKey = GlobalKey<ScaffoldState>();

  var editedNote = NoteModel(
    id: null,
    title: '',
    note: '',
  );
  var initValues = {
    'note': '',
    'title': '',
  };
  var isInit = true;

  List<NoteModel> _items = [];

  List<NoteModel> get items {
    return [..._items];
  }

  NoteModel findById(String id) {
    return _items.firstWhere((contacts) => contacts.id == id);
  }

  addNotes(String pickedTitle, String pickedNote) {
    final newNote = NoteModel(
      id: DateTime.now().toString(),
      title: pickedTitle,
      note: pickedNote,
    );
    _items.add(newNote);
    notifyListeners();
    DBHelper.insert('user_notes', {
      'id': newNote.id,
      'title': newNote.title,
      'note': newNote.note,
    });
  }

  void deleteNote(String id) async {
    //_items.removeWhere((element) => false)
    await DBHelper.delete(id);
    notifyListeners();
  }

  updateContacts(String id, NoteModel noteModel) async {
    final newNote = NoteModel(
      id: DateTime.now().toString(),
      note: noteModel.note,
      title: noteModel.title,
    );
    notifyListeners();
    DBHelper.update(noteModel);
  }

  Future<void> fetchAndSetNote() async {
    final dataList = await DBHelper.getData('user_notes');
    _items = dataList
        .map((item) => NoteModel(
              id: item['id'],
              title: item['title'],
              note: item['note'],
            ))
        .toList();
    notifyListeners();
  }

  void saveNote() {
    if (editedNote.id != null) {
      updateContacts(editedNote.id, editedNote);
    } else {
      addNotes(titleController.text, noteController.text);
      notifyListeners();
    }
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    return null;
  }
}
