import 'package:flutter/material.dart';
import 'package:note_app/notes/models/note.dart';
import 'package:note_app/notes/services/sqlite.dart';
import 'package:note_app/shared/constant.dart';

class NoteProvider with ChangeNotifier{

  final SQliteHelper _db = SQliteHelper();

  List<Note> _items = [];

  Future<void> loadNotes() async{

    List<Map<String , dynamic>> data = await _db.notes;
    _items = data.map((note) {
      return Note(
        id: note['id'],
        title: note['title'],
        body: note['body'],
        creationDate: note['creationDate'],
      );
    }).toList();
    notifyListeners();
  }

  Future<void> addOrUpdate(
    String title , String body ,
     String creationDate , EditMode editMode ,
      [int id] ) async{
    id = await _db.insertNote(
      Note(
      id: id,
      title: title,
      body: body,
      creationDate: creationDate,
    ).toMap(),
    );

    final Note note = Note(
      id: id,
      title: title,
      body: body,
      creationDate: creationDate,
    );
    if(id!=0){
      if(editMode == EditMode.ADD ){
        _items.insert(0, note);
      }
      else if(editMode == EditMode.UPDATE){
        _items[_items.indexWhere((element) => element.id == note.id)] = note;
      }
      notifyListeners();
    }
  }


  Future<void> deletNote (int id) async{
    _items.removeWhere((element) => element.id == id);
    await _db.deleteNote(id);
    notifyListeners();
  }

  List<Note> get items => [..._items];

} 