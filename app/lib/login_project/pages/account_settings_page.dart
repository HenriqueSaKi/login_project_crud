import 'package:flutter/material.dart';
import 'package:login_project/login_project/model/account_settings_person_data.dart';
import 'package:login_project/login_project/pages/accepted_login_page.dart';
import 'package:login_project/login_project/view/content/components/account_settings_textfield_component.dart';
import 'package:http/http.dart' as http;

class AccountSettingsPage extends StatefulWidget {
  String firstName;
  String lastName;
  String email;
  String password;

  AccountSettingsPage({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    Key? key,
  }) : super(key: key);

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  bool showPassword = true;
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstName.text = widget.firstName;
    _lastName.text = widget.lastName;
    _email.text = widget.email;
    _password.text = widget.password;
  }

  bool _isPressed(bool showPassword) {
    if (showPassword == false) {
      return false;
    } else {
      return true;
    }
  }

  String domain = 'localhost';

  _update(AccountSettingsData accountSettingsData) async {
    String url = "http://${domain}:8080/login_project/update";

    http.Response response;
    response = await http.post(url, body: accountSettingsData.toJson());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AcceptedLoginPage(
            email: accountSettingsData.email,
            password: accountSettingsData.password,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        return FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).padding.top,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  child: const Text(
                    'Back',
                    textAlign: TextAlign.start,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AcceptedLoginPage(
                            email: widget.email,
                            password: widget.password,
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, bottom: 20, right: 5),
                          child: const Text(
                            "Account Settings",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            bottom: 20,
                            right: 5,
                          ),
                          child: Icon(
                            Icons.settings,
                            color: Colors.black,
                            size: height / 28,
                          ),
                        ),
                      ],
                    ),
                    AccountSettingsTextField(
                      padding: const EdgeInsets.only(
                        top: 7.5,
                        left: 20,
                        right: 20,
                        bottom: 7.5,
                      ),
                      size: Size.fromHeight(height),
                      controller: _firstName,
                      readOnly: false,
                      text: 'First Name',
                      icon: Icon(Icons.person_outline),
                    ),
                    AccountSettingsTextField(
                      padding: const EdgeInsets.only(
                        top: 7.5,
                        left: 20,
                        right: 20,
                        bottom: 7.5,
                      ),
                      size: Size.fromHeight(height),
                      controller: _lastName,
                      readOnly: false,
                      text: 'Last Name',
                      icon: Icon(Icons.person_outline),
                    ),
                    AccountSettingsTextField(
                      padding: const EdgeInsets.only(
                        top: 7.5,
                        left: 20,
                        right: 20,
                        bottom: 7.5,
                      ),
                      size: Size.fromHeight(height),
                      controller: _email,
                      readOnly: true,
                      text: 'E-mail',
                      icon: Icon(Icons.email_outlined),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 7.5,
                        left: 20,
                        right: 20,
                        bottom: 7.5,
                      ),
                      height: height / 12,
                      child: TextField(
                        controller: _password,
                        obscureText: _isPressed(showPassword),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffix: TextButton(
                            onPressed: () {
                              showPassword =
                                  (showPassword == false ? true : false);
                              _isPressed(showPassword);
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.remove_red_eye_outlined,
                            ),
                          ),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 7.5,
                        left: 20,
                        right: 20,
                        bottom: 7.5,
                      ),
                      height: height / 14,
                      child: ElevatedButton(
                        child: const Text('Save'),
                        onPressed: () {
                          AccountSettingsData accountSettingsData =
                              AccountSettingsData(
                            _firstName.text,
                            _lastName.text,
                            _email.text,
                            _password.text,
                          );
                          _update(accountSettingsData);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
