
// ignore_for_file: prefer_final_fields, unused_field, unnecessary_this

class User {
  String _name = "";
  String _password = "";
  String _email = "";
  int _ra = 0;

  User(this._email, this._password, this._name, this._ra);

  String get name => this._name;

  set name(String value) => this._name = value;

  get password => this._password;

  set password( value) => this._password = value;

  get email => this._email;

  set email( value) => this._email = value;

  get ra => this._ra;

  set ra( value) => this._ra = value;
}