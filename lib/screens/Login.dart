import 'package:chatapp/auth/methods.dart';
import 'package:chatapp/chatdatabase/home_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  bool isLoading = false;
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff1d1e26),
            Color(0xff252041),
          ])),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Login ",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(
              height: 20,
            ),
            textitem("Email", emailController, false),
            SizedBox(height: 15),
            textitem("Password", pwdController, true),
            SizedBox(height: 15),
            Loginbutton(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "If you dont have an Account? ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Forgotten Password??",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ])),
    ));
  }

  Widget textitem(
      String labeltext, TextEditingController controller, bool obscureText) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width - 70,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget Loginbutton() {
    return GestureDetector(
      onTap: () {
        if (emailController.text.isNotEmpty && pwdController.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          logIn(
            emailController.text,
            pwdController.text,
          ).then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Home()));
              print("logIN Sucessfull");
            } else {
              print("LogIN Failed");
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please enter Fields");
        }
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        child: Center(
          child: circular
              ? CircularProgressIndicator()
              : Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
