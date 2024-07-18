class Note {

  int? _id;
  String? _title;
  String? _description;
  String? _date;
  int? _priority;

  Note(this._title, this._date, this._priority, [this._description = 'N/A']);

  Note.withId(this._id, this._title, this._date, this._priority, [this._description = 'N/A']);

  int get priority => _priority ?? 1;

  set priority(int value) {
    if (value >= 1 && value <= 2) {
      _priority = value;
    }
  }

  String get date => _date ?? 'N/A';

  set date(String value) {
    _date = value;
  }

  String get description => _description ?? 'N/A';

  set description(String value) {
    if (value.length <= 255) {
      _description = value;
    }
  }

  String get title => _title ?? 'N/A';

  set title(String value) {
    if (value.length <= 255) {
      _title = value;
    }
  }

  int get id => _id ?? 1;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
    this._priority = map['priority'];
  }
}