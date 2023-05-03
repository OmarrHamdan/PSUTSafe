import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:psutsafe/Screens/LoginSignupScreen.dart';

class Auth {
  Future<bool> SignUp(
      String fname,
      String lname,
      String email,
      String num,
      String major,
      List medical,
      String usertype,
      String uniId,
      String pass,
      String token) async {
    UserCredential authservice = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass);

    User? signedInUser = authservice.user;

    if (signedInUser != null) {
      FirebaseFirestore.instance.collection('Users').doc(signedInUser.uid).set({
        'firstname': fname,
        'lastname': lname,
        'email': email,
        'number': num,
        'uniId': uniId,
        'profilePicture': '',
        'medicalCondition': medical,
        'userType': usertype,
        'bio': '',
        'major': major,
        'adminOrNot': false,
        'lowerCaseName': '',
        'notificationToken': token
      });
    }
    FirebaseAuth.instance.signOut();
    return true;
  }

  Future<bool> SignIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }
}
