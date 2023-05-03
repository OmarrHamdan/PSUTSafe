import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psutsafe/Models/ReportModel.dart';
import 'package:psutsafe/Models/UserModel.dart';

class UserController {
  static Future<UserModel> getUser(String thisUser) async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(thisUser)
        .get();
    UserModel user = UserModel.fromDoc(userSnapshot);
    return user;
  }

  static Future<void> addProfilePic(String profilePic, String UserId) async {
    FirebaseFirestore.instance.collection('Users').doc(UserId).update({
      'profilePicture': profilePic,
    });
  }

  static Future<List> getAllReports(String UserId) async {
    QuerySnapshot ReportsSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(UserId)
        .collection('Reports')
        .get();
    List<ReportModel> Reports =
        ReportsSnapshot.docs.map((doc) => ReportModel.fromDoc(doc)).toList();
    return Reports;
  }

  static Future<void> updateToken(String token, String UserID) async {
    FirebaseFirestore.instance.collection('Users').doc(UserID).update({
      'notificationToken': token,
    });
  }
}
