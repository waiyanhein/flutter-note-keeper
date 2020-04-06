import 'package:app/mdels/note.dart';
import 'package:app/screens/note_form.dart';
import 'package:app/utils/database_helper.dart';
import 'package:flutter/material.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {
  List<Note> _notes = [];
  int _count = 0;
  DatabaseHelper _databaseHelper = DatabaseHelper();

  _NoteListState() {
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: Builder(
        builder: (scaffoldContext) => Container(
          child: getListView(context, scaffoldContext),
        ),
      ),
      floatingActionButton: Builder(
        builder: (scaffoldContext) => FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            navigateToNoteForm(scaffoldContext, "Add Note");
          },
        ),
      ),
    );
  }

  Widget getListView(BuildContext context, BuildContext scaffoldContext) {
    return ListView.builder(
        itemCount: _count,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  _notes[index].priority == 1 ? Colors.yellow : Colors.red,
              child: Icon(
                  _notes[index].priority == 1 ? Icons.arrow_right : Icons.add),
            ),
            title: Text(_notes[index].title),
            subtitle: Text(_notes[index].date),
            trailing: Icon(Icons.delete),
            onTap: () {
              navigateToNoteForm(scaffoldContext, "Edit Note", _notes[index]);
            },
          );
        });
  }

  void navigateToNoteForm(BuildContext scaffoldContext, String pageTitle,
      [Note note]) async {
    bool update =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteForm(pageTitle, note);
    }));

    if (update) {
      this.showSnackBar(scaffoldContext, "Note has been updated.");
    } else {
      this.showSnackBar(scaffoldContext, "A note has been added.");
    }

    getNotes();
  }

  void getNotes() {
    List<Note> notes = List<Note>();
    Future<List<Map<String, dynamic>>> notesFuture =
        _databaseHelper.getNoteMapList();
    notesFuture.then((notesMap) {
      debugPrint("Total notes found in the database ${notesMap.length}");
      notesMap.forEach((map) {
        notes.add(Note.fromMapObject(map));
      });

      setState(() {
        _notes = notes;
        _count = notes.length;
      });
    });
  }

  void showSnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: "UNDO",
        onPressed: () {},
      ),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
