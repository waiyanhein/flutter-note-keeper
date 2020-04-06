
class Note
{
  int _id;
  String _title;
  String _description;
  int _priority;
  String _date;

  int get id => _id;
  String get title => _title;
  String get description => _description;
  int get priority => _priority;
  String get date => _date;

  Note();

  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
    this._priority = map['priority'];
  }

  void set id(int id) {
    _id = id;
  }

  void set title(String newTitle) {
    _title = newTitle;
  }

  void set description(String newDescription) {
    _description = newDescription;
  }

  void set priority(int newPriority) {
    _priority = newPriority;
  }

  void set date(String newDate) {
    _date = newDate;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (_id != null && _id > 0) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }
}
