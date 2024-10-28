class Account {

  int _id = 0;
  String _name = "";
  String _email = "";
  String _password = "";
  String _username = "";
  int _active = 1;
  int _type = 1;

  Account();

  Account.fromJson(Map<String, dynamic> json):
  _id = json['id'],
  _name = json['name'],
  _email = json['email'],
  _password = json['password'],
  _username = json['username'],
  _active = json['active'],
  _type = json['type']
  ;

  int get id => this._id;
  set id(int value) => this._id = value;

  get name => this._name;
  set name( value) => this._name = value;

  get email => this._email;
  set email( value) => this._email = value;

  get password => this._password;
  set password( value) => this._password = value;

  get username => this._username;
  set username( value) => this._username = value;

  get active => this._active;
  set active( value) => this._active = value;

  get type => this._type;
  set type( value) => this._type = value;


}