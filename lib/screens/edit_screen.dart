import 'package:flutter/material.dart';
import 'package:note_app/notes/models/note.dart';
import 'package:note_app/notes/provider/note_provider.dart';
import 'package:note_app/shared/constant.dart';
import 'package:provider/provider.dart';

class EditNoteScreen extends StatelessWidget {
  static const String id = 'editNote_screen';
  final Note note;

  EditNoteScreen({this.note});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController bodyController = TextEditingController();
    titleController.text = note.title;
    bodyController.text = note.body;
    return Consumer<NoteProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Edit your Note"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Note Title",
                ),
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Write Your Note",
                ),
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            value
                .addOrUpdate(titleController.text, bodyController.text,
                    DateTime.now().toString(), EditMode.UPDATE , note.id)
                .then((value) => Navigator.pop(context));
          },
          label: Text("Save Note"),
          icon: Icon(Icons.save),
        ),
      ),
    );
  }
}