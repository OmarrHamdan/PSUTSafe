import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:psutsafe/Controllers/UserController.dart';
import 'package:psutsafe/Models/UserModel.dart';
import 'package:psutsafe/Controllers/HomeController.dart';
import 'package:psutsafe/Models/ReportModel.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:psutsafe/Screens/AddReportScreen.dart';

import '../Controllers/UserController.dart';

class AddReportScreen extends StatefulWidget {
  final String thisUser;
  const AddReportScreen({super.key, required this.thisUser});

  @override
  State<AddReportScreen> createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
  String _reportText = '';
  List<UserModel> Users = [];
  String _reportImage = '';
  UserModel? _user;
  bool _imageUploaded = false;
  TextEditingController txt = new TextEditingController();

  var channel;
  var flutterLocalNotificationsPlugin;

  requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings permission = await messaging.requestPermission(
      alert: true,
      badge: true,
    );
  }

  getAllUsers() async {
    Users = await HomeController.getAllUsers() as List<UserModel>;
  }

  getall() async {
    _user = await UserController.getUser(widget.thisUser);
    await requestPermission();
    await firebaseMessagingLOAD();
    await firebaseMessagingListen();
    if (mounted) setState(() {});
  }

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

  Future<void> uploadPicture() async {
    ImagePicker picker = ImagePicker();

    bool? isGallery = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 8, 29, 170)),
                maximumSize: MaterialStateProperty.all<Size>(Size.infinite),
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size.fromHeight(40)),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("Gallery"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 8, 29, 170)),
                maximumSize: MaterialStateProperty.all<Size>(Size.infinite),
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size.fromHeight(40)),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(" Camera"),
            ),
          ],
        ),
      ),
    );

    if (isGallery == null) return;

    XFile? file = await picker.pickImage(
        source: isGallery ? ImageSource.gallery : ImageSource.camera);

    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    Reference referenceDirImages = FirebaseStorage.instance.ref();
    Reference refImagetoupload = referenceDirImages.child(uniqueFileName);

    try {
      await refImagetoupload.putFile(File(file!.path));
      _reportImage = await refImagetoupload.getDownloadURL();
      _imageUploaded = true;
      if (mounted) {
        setState(() {});
      }
    } catch (error) {
      print('object');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 8, 29, 170),
        title: const Text('Report'),
        actions: [
          IconButton(
            onPressed: () async {
              if (_imageUploaded && _reportText != '') {
                ReportModel report = ReportModel(
                    ReportText: _reportText,
                    creatorId: widget.thisUser,
                    reportImage: _reportImage);
                HomeController.addReport(report);
                for (var x in Users) {
                  HomeController.sendNotification(
                      'User report has been posted, please refer to the PSUT application',
                      'ALERT',
                      x.notificationToken!);
                  if (mounted) {
                    setState(() {});
                  }
                }
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 2250),
                  content: Text("Please fill all the fields and the Image"),
                ));
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: (BorderRadius.circular(10)),
                  color: Colors.white,
                  border: Border.all(color: Color.fromARGB(255, 8, 29, 170))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: txt,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What is happening?',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 116, 114, 114),
                    ),
                  ),
                  onChanged: (value) {
                    _reportText = value.trim();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 8, 29, 170)),
                      maximumSize:
                          MaterialStateProperty.all<Size>(Size.infinite),
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size.fromHeight(40)),
                    ),
                    onPressed: () {
                      _reportText = 'Fight';
                      txt.text = 'Fight';
                    },
                    child: Text("Fight"),
                  ), // <-- Wrapped in Flexible.
                ),
                SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 8, 29, 170)),
                      maximumSize:
                          MaterialStateProperty.all<Size>(Size.infinite),
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size.fromHeight(40)),
                    ),
                    onPressed: () {
                      _reportText = 'Flood';
                      txt.text = 'Flood';
                    },
                    child: Text("Flood"),
                  ), // <-- Wrapped in Flexible.
                ),
                SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 8, 29, 170)),
                      maximumSize:
                          MaterialStateProperty.all<Size>(Size.infinite),
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size.fromHeight(40)),
                    ),
                    onPressed: () {
                      _reportText = 'Earthquake';
                      txt.text = 'Earthquake';
                    },
                    child: Text(
                      "Earthquake",
                      style: TextStyle(fontSize: 10),
                    ),
                  ), // <-- Wrapped in Flexible.
                ),
                SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 8, 29, 170)),
                      maximumSize:
                          MaterialStateProperty.all<Size>(Size.infinite),
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size.fromHeight(40)),
                    ),
                    onPressed: () {
                      _reportText = 'Fire';
                      txt.text = 'Fire';
                    },
                    child: Text("Fire"),
                  ), // <-- Wrapped in Flexible.
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 8, 29, 170)),
                maximumSize: MaterialStateProperty.all<Size>(Size.infinite),
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size.fromHeight(40)),
              ),
              onPressed: () {
                uploadPicture();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text('Image', style: TextStyle(color: Colors.white)),
                  const Icon(
                    Icons.image,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Visibility(
              visible: _imageUploaded,
              child: Container(
                transform: Matrix4.translationValues(0, 60, 0),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(_reportImage as String),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
