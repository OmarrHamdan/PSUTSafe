import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ntp/ntp.dart';
import 'package:http/http.dart' as http;
import 'package:psutsafe/Models/UserModel.dart';

import '../Models/ReportModel.dart';

class HomeController {
  static Future<List> getAllReports() async {
    QuerySnapshot ReportsSnapshot =
        await FirebaseFirestore.instance.collection('Reports').get();
    List<ReportModel> Reports =
        ReportsSnapshot.docs.map((doc) => ReportModel.fromDoc(doc)).toList();
    return Reports;
  }

  static Future<void> addReport(ReportModel report) async {
    FirebaseFirestore.instance.collection('Reports').add({
      'ReportText': report.ReportText,
      'reportImage': report.reportImage,
      'dateReported': await NTP.now(),
      'creatorId': report.creatorId,
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(report.creatorId)
        .collection('Reports')
        .add({
      'ReportText': report.ReportText,
      'reportImage': report.reportImage,
      'dateReported': await NTP.now(),
      'creatorId': report.creatorId,
    });
  }

  static void sendNotification(String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAEv9i9Ag:APA91bHo39R5yEqEChVp0OgVqoTMKssqNVYrP8X8ViCHv19jo2RV_m0f8AUJ2-DOyZmQ3p4ZIktSfESkeYANZVg4ieLY70MxifXeZlNpkibbrv85DcYyiGjGU3ASQDnRM9SGkEcsyItZ',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
    } catch (e) {}
  }

  static Future<List> getAllUsers() async {
    QuerySnapshot usersSnapshot =
        await FirebaseFirestore.instance.collection('Users').get();
    List<UserModel> users = [];
    for (int i = 0; i < usersSnapshot.docs.length; i++) {
      users.add(UserModel.fromDoc(usersSnapshot.docs[i]));
    }
    return users;
  }
}
