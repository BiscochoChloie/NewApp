// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:q/Models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/authServices.dart';
import 'homePage.dart';
import 'register.dart';
import 'widgets/button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  InputDecoration inputDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    );
  }

  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Enter Valid Email';
    }
    if (value.isEmpty) {
      return 'Enter Password';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
// Indian Mobile number are of 10 digit only
    if (value!.isEmpty) {
      return 'Enter Password';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.black,
              )),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Column(
                      children: const [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: emailController,
                                obscureText: false,
                                decoration: inputDecoration(),
                                validator: validateEmail,
                              ),
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Password",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: inputDecoration(),
                                validator: validatePassword,
                              ),
                              SizedBox(
                                height: 30,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    ButtonWidget(
                      text: 'Login',
                      onClicked: () async {
                        await AuthServices.logIn(
                          emailController.text,
                          passwordController.text,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Does not have account?'),
                        TextButton(
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
