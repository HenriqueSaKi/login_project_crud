class AccountSettingsData {
  String _firstName;
  String _lastName;
  String _email;
  String _password;

  AccountSettingsData(
      this._firstName, this._lastName, this._email, this._password);

  String get firstName => _firstName;

  set firstName(String firstName) {
    _firstName = firstName;
  }

  String get lastName => _lastName;

  set lastName(String lastName) {
    _lastName = lastName;
  }

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
      'firstName': this._firstName,
      'lastName': this._lastName,
      'email': this._email,
      'password': this._password,
    };
  }
}
