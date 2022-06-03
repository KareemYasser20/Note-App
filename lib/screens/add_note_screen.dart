import 'package:flutter/material.dart';
import 'package:note_app/notes/provider/note_provider.dart';
import 'package:note_app/shared/constant.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatelessWidget {
  static const String id = 'addNote_screen';

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController bodyController = TextEditingController();
    return Consumer<NoteProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Add New Note"),
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
                    DateTime.now().toString(), EditMode.ADD)
                .then((value) => Navigator.pop(context));
          },
          label: Text("Save Note"),
          icon: Icon(Icons.save),
        ),
      ),
    );
  }
}
