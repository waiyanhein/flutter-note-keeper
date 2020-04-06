import 'package:app/mdels/note.dart';
import 'package:app/utils/database_helper.dart';
import 'package:flutter/material.dart';

class NoteForm extends StatefulWidget {
  String _title = "";
  Note _note = null;

  NoteForm(String title, [Note note]) {
    this._title = title;
    this._note = note;
    if (note!=null) {
      print("note id passed to note form is ${note.id}");
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _NoteFormState(this._title, this._note);
  }
}

class _NoteFormState extends State<NoteForm> {

  double _minimumPadding = 15.0;
  var _priorities = [ 1, 2 ];
  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _dateController = TextEditingController();
  DatabaseHelper _databaseHelper = DatabaseHelper();
  var _selectedPriority = 1;
  String _title;
  Note _note;

  _NoteFormState(String title, [Note note]) {
    this._title = title;
    this._note = note;
    if (this._note != null && this._note.id != null) {
      _titleController.text = this._note.title;
      _descriptionController.text = this._note.description;
      _dateController.text = this._note.date;
      _selectedPriority = this._note.priority;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(this._title),),
      body: Builder(
        builder: (scaffoldContext) => Form(
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.all(_minimumPadding),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        labelText: "Title",
                        hintText: "Enter title"
                    ),
                  ),
                ),
              ),
              Container(
                  child: Padding(
                    padding: EdgeInsets.all(_minimumPadding),
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                          labelText: "Description",
                          hintText: "Enter description"
                      ),
                    ),
                  )
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(_minimumPadding),
                  child: TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                        labelText: "Date",
                        hintText: "Enter date"
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(_minimumPadding),
                  child: DropdownButton<int>(
                    value: _selectedPriority,
                    items: _priorities.map((dropdownItem) {
                      return DropdownMenuItem<int>(
                        value: dropdownItem,
                        child: Text(dropdownItem == 1? "Low": "High"),
                      );
                    }).toList(),
                    onChanged: (int newSelectedValue) {
                      setState(() {
                        _selectedPriority = newSelectedValue;
                      });
                    },
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(_minimumPadding),
                  child: RaisedButton(
                    child: Text(
                        "Save"
                    ),
                    onPressed: () {
                      _save(scaffoldContext);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  void _save(BuildContext context) async {
    Note note = Note();
    if (_note!=null && _note.id!=null) {
      note.id = _note.id;
    }
    note.title = _titleController.text;
    note.description = _descriptionController.text;
    note.date = _dateController.text;
    note.priority = _selectedPriority;

    if (widget._note != null && widget._note.id!=null) {
      //update
      debugPrint("Note id is ${note.id}");
      debugPrint("Note title is ${note.title}");
      debugPrint("Note description is ${note.description}");
      debugPrint("Note date is ${note.date}");
      debugPrint("Note priority is ${note.priority}");
      debugPrint("Note has been updated.");
      await _databaseHelper.updateNote(note).then((result) {
        closeForm(context, true);
      });
    } else {
      //create
      debugPrint("Note has been created.");
      await _databaseHelper.insertNote(note).then((result) {
        closeForm(context, false);
      });
    }
  }

  void closeForm(BuildContext context, bool update) {
    Navigator.pop(context, update);
  }
}
