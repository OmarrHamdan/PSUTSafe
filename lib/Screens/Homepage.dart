import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:psutsafe/Controllers/HomeController.dart';
import 'package:psutsafe/Controllers/UserController.dart';
import 'package:psutsafe/Models/UserModel.dart';
import 'package:psutsafe/Screens/AddReportScreen.dart';
import 'package:psutsafe/Screens/ForgotPassword.dart';
import 'package:psutsafe/Screens/SignUpScreen.dart';
import 'package:psutsafe/Services/Auth.dart';
import 'package:psutsafe/Widgets/ReportWidget.dart';

import '../Models/ReportModel.dart';

class HomePage extends StatefulWidget {
  final String thisUser;

  const HomePage({super.key, required this.thisUser});
  @override
  State<HomePage> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePage> {
  bool sit = false;
  List allReports = [];
  List Reports = [];
  List<UserModel> Users = [];
  UserModel? _user;
  getAllReports() async {
    allReports = await HomeController.getAllReports();
  }

  var channel;
  var flutterLocalNotificationsPlugin;

  requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings permission = await messaging.requestPermission(
      alert: true,
      badge: true,
    );
  }

  Future<void> openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Are you sure you want to Declare a crisis?"),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 8, 29, 170)),
                ),
                onPressed: () async {
                  sit = true;
                  for (var x in Users) {
                    HomeController.sendNotification(
                        'Crisis Declared, everyone report to the PSUTSafe application ',
                        'ALERT',
                        x.notificationToken!);
                    if (mounted) {
                      setState(() {});
                    }
                  }
                  Navigator.pop(context);
                },
                child: const Text("Declare"),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 8, 29, 170)),
                ),
                onPressed: () async {
                  sit = false;
                  for (var x in Users) {
                    HomeController.sendNotification(
                        'Crisis Declaration has stopped ',
                        'ALERT',
                        x.notificationToken!);

                    if (mounted) {
                      setState(() {});
                    }
                  }
                  Navigator.pop(context);
                },
                child: const Text("Stop Crisis Declaration"),
              ),
            ],
          ));

  firebaseMessagingLOAD() async {
    if (!kIsWeb) {
      // ignore: prefer_const_constructors
      channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        'High imp desc',
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  firebaseMessagingListen() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  combinePostsToOneList() {
    for (ReportModel report in allReports) {
      Reports.add(ReportWidget(
        report: report,
        thisUser: widget.thisUser,
      ));
      Reports.add(const SizedBox(
        height: 10,
      ));
    }
  }

  getAllUsers() async {
    Users = await HomeController.getAllUsers() as List<UserModel>;
  }

  getall() async {
    _user = await UserController.getUser(widget.thisUser);
    await getAllReports();
    await combinePostsToOneList();
    await getAllUsers();
    await requestPermission();
    await firebaseMessagingLOAD();
    await firebaseMessagingListen();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getall();
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(backgroundColor: Color.fromARGB(255, 28, 28, 28), actions: [
          Icon(Icons.circle,
              size: 35,
              color: sit == false
                  ? Color.fromARGB(255, 0, 255, 8)
                  : Color.fromARGB(255, 255, 17, 0)),
          SizedBox(
              width: 100,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(widget.thisUser)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox.shrink();
                  }
                  UserModel userModel =
                      UserModel.fromDoc(snapshot.data as DocumentSnapshot);
                  if (userModel.adminOrNot == true) {
                    return ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 8, 29, 170)),
                        maximumSize:
                            MaterialStateProperty.all<Size>(Size.infinite),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size.fromHeight(10)),
                      ),
                      onPressed: () {
                        openDialog();
                      },
                      child: const Text('Declare Crisis'),
                    );
                  }
                  return const SizedBox.shrink();
                },
              )),
          Spacer(),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddReportScreen(
                            thisUser: widget.thisUser,
                          )),
                );
              },
              icon: Icon(Icons.add))
        ]),
        backgroundColor: Colors.black,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          children: [
            SizedBox(
              height: 17,
            ),
            ...Reports
          ],
        ))));
  }
}
