import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_project/login_project/model/login_person_data.dart';
import 'package:login_project/login_project/pages/accepted_login_page.dart';
import 'package:login_project/login_project/pages/login_page.dart';

class DeleteAccountPage extends StatefulWidget {
  String email;
  String password;

  DeleteAccountPage({
    required this.email,
    required this.password,
    Key? key,
  }) : super(key: key);

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  bool? _delete = false;
  bool errorMessageVisible = false;
  String errorMessage = "";
  bool errorMessagePopUpVisible = false;
  String errorMessagePopUp = "";
  final TextEditingController _password = TextEditingController();

  String domain = "localhost";

  _deleteAccount(Login login) async {
    String url = "http://${domain}:8080/login_project/delete";
    await http.post(url, body: login.toJson());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const LoginPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
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
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: const Text(
                        "Delete account",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15, bottom: 20),
                      child: const Text(
                        'Are you sure you want to delete your account?',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _delete,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _delete = newValue;
                        });
                      },
                    ),
                    const Text(
                      "Yes, I'm sure.",
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Visibility(
                    visible: errorMessageVisible,
                    child: Text(
                      errorMessage,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 8,
                      ),
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
                  height: height / 15,
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.delete,
                        ),
                        const Text(
                          '  Confirm Deletion',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: () {
                      errorMessageVisible = false;
                      if (_delete == true) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => StatefulBuilder(
                            builder: (context, StateSetter setState) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("Please enter your password:"),
                                    Visibility(
                                      child: Text(
                                        errorMessagePopUp,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                      visible: errorMessagePopUpVisible,
                                    ),
                                    SizedBox(
                                      height: height / 20,
                                      child: TextField(
                                        controller: _password,
                                        obscureText: true,
                                      ),
                                    )
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    child: const Text(
                                      'Confirm',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                    ),
                                    onPressed: () {
                                      errorMessagePopUpVisible = false;
                                      if (widget.password == _password.text) {
                                        var login = Login(
                                          widget.email,
                                          _password.text,
                                        );
                                        _deleteAccount(login);
                                      } else {
                                        setState(() {
                                          errorMessagePopUp =
                                              'Please enter your password properly.';
                                          errorMessagePopUpVisible = true;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      } else {
                        setState(() {
                          errorMessage =
                              'If you are sure, please check the option above.';
                          errorMessageVisible = true;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
