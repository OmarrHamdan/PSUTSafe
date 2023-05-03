import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psutsafe/Screens/FeedScreen.dart';
import 'package:psutsafe/Screens/Homepage.dart';
import 'package:psutsafe/Screens/LoginSignupScreen.dart';

Future<void> main() async {
  //makes the status bar the same color as the app bar
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  Widget getHomeOrLogin() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return LoginSignupScreen();
          } else {
            return FeedScreen(thisUser: FirebaseAuth.instance.currentUser!.uid);
          }
        });
  }

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: getHomeOrLogin(),
    );
  }
}
