import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_project/login_project/model/account_settings_person_data.dart';
import 'package:login_project/login_project/model/login_person_data.dart';
import 'package:login_project/login_project/pages/account_settings_page.dart';
import 'package:login_project/login_project/pages/delete_account_page.dart';
import 'package:login_project/login_project/pages/login_page.dart';
import 'package:http/http.dart' as http;

class AcceptedLoginPage extends StatefulWidget {
  String email;
  String password;

  AcceptedLoginPage({
    required this.email,
    required this.password,
    Key? key,
  }) : super(key: key);

  @override
  State<AcceptedLoginPage> createState() => _AcceptedLoginPageState();
}

class _AcceptedLoginPageState extends State<AcceptedLoginPage> {
  String domain = "localhost";

  _acceptedLogin(Login login) async {
    String url = "http://${domain}:8080/login_project/user";

    http.Response response;
    response = await http.post(url, body: login.toJson());

    final LinkedHashMap responseBody = jsonDecode(response.body);

    AccountSettingsData accountSettingsData = AccountSettingsData(
      responseBody['firstName'],
      responseBody['lastName'],
      responseBody['email'],
      responseBody['password'],
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AccountSettingsPage(
            firstName: accountSettingsData.firstName,
            lastName: accountSettingsData.lastName,
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
    //double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: TextButton(
                  child: const Icon(
                    Icons.settings,
                  ),
                  onPressed: () {
                    Login login = Login(
                      widget.email,
                      widget.password,
                    );
                    _acceptedLogin(login);
                  },
                ),
              )
            ],
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "It's working!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    height: height / 30,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.logout),
                          Text('   Logout'),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginPage();
                            },
                          ),
                        );
                      },
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.delete),
                          Text('   Delete Account'),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DeleteAccountPage(
                                email: widget.email,
                                password: widget.password,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
