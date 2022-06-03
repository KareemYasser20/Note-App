import 'package:flutter/material.dart';
import 'package:note_app/notes/provider/note_provider.dart';
import 'package:note_app/screens/edit_screen.dart';
import 'package:note_app/shared/constant.dart';
import 'package:note_app/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'add_note_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
   
    return FutureBuilder(
      future: Provider.of<NoteProvider>(context, listen: false).loadNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Your Note"),
            ),
            body: Consumer<NoteProvider>(
              builder: (context, value, child) => value.items.isEmpty? Center(child:Text('Your Note List is Empty.')) : ListView.separated(
                itemBuilder: (context, index) => Card(
                  child: SlidableWidget(
                    onDismissed: (action) =>
                        dismissSlidableItem(context, index, action , value),
                    listTileWidget: ListTile(
                      onTap: () {},
                      title: Text(value.items[index].title),
                      subtitle: Text(value.items[index].body),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                itemCount: value.items.length,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddNoteScreen()));
              },
              child: Icon(Icons.note_add),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("Your Notes"),
          ),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

 void dismissSlidableItem(
        BuildContext context, int index, SlidableAction action , NoteProvider value) {
      switch (action) {
        case SlidableAction.EDIT:
        Navigator.push(context, 
        MaterialPageRoute(builder: (context) => EditNoteScreen(note: value.items[index]))
        );
        Utils.showSnackBar(context, 'Note has been Edited');
          break;
        case SlidableAction.DELETE:
        value.deletNote(value.items[index].id);
        Utils.showSnackBar(context, 'Note has been deleted');
          break;
      }
    }


class SlidableWidget extends StatelessWidget {
  @required final Widget listTileWidget;
  @required final Function(SlidableAction action) onDismissed;

  SlidableWidget({this.listTileWidget, this.onDismissed});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(0),
      actionPane: SlidableDrawerActionPane(),
      // left side
      actions: <Widget>[
       IconSlideAction(
          caption: 'Edit',
          color: Colors.blue.shade300,
          icon: Icons.edit,
          onTap: () => onDismissed(SlidableAction.EDIT),
        ),
      ],

      // right side

      secondaryActions: <Widget>[
        
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => onDismissed(SlidableAction.DELETE),
        ),
      ],
      child: listTileWidget,
    );
  }
}
