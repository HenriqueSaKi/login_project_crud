class Login {
  String _email;
  String _password;

  Login(
    this._email,
    this._password,
  );

  String get email => _email;

  set email(String email) {
    _email = email;
  }

  String get password => _password;

  set password(String password) {
    _password = password;
  }

  Map<String, String> toJson() {
    return {
      'email': this._email,
      'password': this._password,
    };
  }
}
