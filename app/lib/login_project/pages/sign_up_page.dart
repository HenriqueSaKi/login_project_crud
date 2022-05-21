import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_project/login_project/model/sign_up_person_data.dart';
import 'package:login_project/login_project/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:login_project/login_project/view/content/components/sing_up_page_textfield_component.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool showPassword = true;
  bool errorSignInMessage = false;
  String errorMessage = '';

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _isPressed(bool showPassword) {
    if (showPassword == false) {
      return false;
    } else {
      return true;
    }
  }

  String domain = "localhost";

  _register(PersonData personData) async {
    String url = "http://${domain}:8080/login_project/register";

    http.Response response;
    response = await http.post(url, body: personData.toJson());

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LoginPage();
          },
        ),
      );
    } else if (response.statusCode == 409) {
      setState(() {
        errorMessage = response.body;
        errorSignInMessage = true;
      });
    } else {
      setState(() {
        errorMessage = response.body;
        errorSignInMessage = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;

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
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Create Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 35,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          child: const Text('Log-in'),
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
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 10,
                        ),
                        child: Visibility(
                          child: Text(
                            errorMessage,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          visible: errorSignInMessage,
                        ),
                      ),
                    ),
                    SignUpTextField(
                      padding: const EdgeInsets.only(
                        top: 7.5,
                        left: 20,
                        right: 20,
                        bottom: 7.5,
                      ),
                      size: Size.fromHeight(height),
                      controller: _firstName,
                      text: 'First Name',
                      icon: Icon(Icons.person_outline),
                    ),
                    SignUpTextField(
                      padding: const EdgeInsets.only(
                        top: 7.5,
                        left: 20,
                        right: 20,
                        bottom: 7.5,
                      ),
                      size: Size.fromHeight(height),
                      controller: _lastName,
                      text: 'Last Name',
                      icon: Icon(Icons.person_outline),
                    ),
                    SignUpTextField(
                      padding: const EdgeInsets.only(
                        top: 7.5,
                        left: 20,
                        right: 20,
                        bottom: 7.5,
                      ),
                      size: Size.fromHeight(height),
                      controller: _email,
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
                        child: const Text('Sign-in'),
                        onPressed: () {
                          PersonData personData = PersonData(
                            _firstName.text,
                            _lastName.text,
                            _email.text,
                            _password.text,
                          );
                          _register(personData);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
