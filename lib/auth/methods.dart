import 'package:chatapp/screens/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<User?> SignUpHere(String name, String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCrendetial = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    print("Account created Succesfull");

    userCrendetial.user!.updateDisplayName(name);

    await firestore.collection('users').doc(auth.currentUser!.uid).set({
      "name": name,
      "email": email,
      "status": "Unavalible",
      "uid": auth.currentUser!.uid,
    });

    return userCrendetial.user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    print("Login Sucessfull");
    firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) => userCredential.user!.updateDisplayName(value['name']));

    return userCredential.user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.pop(context, MaterialPageRoute(builder: (context) => Login()));
    });
  } catch (e) {
    print("error");
  }
}
