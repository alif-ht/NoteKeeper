import 'package:flutter/material.dart';
import 'package:notekeeper/models/note.dart';
import 'package:notekeeper/screens/note_detail.dart';
import 'package:notekeeper/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  late List<Note> noteList;
  int count = 0;

  //get databaseHelper => null;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

      noteList = <Note>[];
      updateListView();


    return Scaffold(

      appBar: AppBar(
        title: Text('Notes'),
      ),

      body: getNoteListView(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(Note('', '', 2), 'Add Note');
        },

        tooltip: 'Add Note',

        child: Icon(Icons.add),

      ),
      
    );
  }

  ListView getNoteListView() {
    TextStyle? titleStyle = Theme.of(context).textTheme.labelLarge;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: const CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.keyboard_arrow_right),
            ),

            title: Text('#Title' ,  style: titleStyle,),

            subtitle: Text('#Date'),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, noteList[position]);
              },
            ),

            onTap: () {
              debugPrint('ListTile tapped');
              navigateToDetail(this.noteList[position], 'Edit Note');
            },

          ),
        );
      },
    );
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async {

    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {

    /*final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);*/
    debugPrint(message);
  }

  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  Future<void> navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }
}