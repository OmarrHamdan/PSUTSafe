import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? profilePicture;
  String? email;
  String? bio;
  String? number;
  String? uniId;
  List? medicalCondition;
  String? userType;
  String? major;
  bool? adminOrNot;
  String? notificationToken;
  String? lowerCaseName;

  UserModel(
      {this.id,
      this.firstname,
      this.lastname,
      this.uniId,
      this.profilePicture,
      this.email,
      this.number,
      this.medicalCondition,
      this.bio,
      this.notificationToken,
      this.major,
      this.userType,
      this.adminOrNot,
      this.lowerCaseName});

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id, //String
      firstname: doc.data().toString().contains('firstname')
          ? doc.get('firstname')
          : '', //String
      lastname: doc.data().toString().contains('lastname')
          ? doc.get('lastname')
          : '', //String
      email: doc.data().toString().contains('email')
          ? doc.get('email')
          : '', //String
      medicalCondition: doc.data().toString().contains('medicalCondition')
          ? doc.get('medicalCondition')
          : '',
      uniId: doc.data().toString().contains('uniId') ? doc.get('uniId') : '',
      number: doc.data().toString().contains('number') ? doc.get('number') : '',
      profilePicture: doc.data().toString().contains('profilePicture')
          ? doc.get('profilePicture')
          : '', //String
      bio: doc.data().toString().contains('bio') ? doc.get('bio') : '', //String
      major: doc.data().toString().contains('major')
          ? doc.get('major')
          : '', //String

      adminOrNot: doc.data().toString().contains('adminOrNot')
          ? doc.get('adminOrNot')
          : false,
      notificationToken: doc.data().toString().contains('notificationToken')
          ? doc.get('notificationToken')
          : '',
      lowerCaseName: doc.data().toString().contains('lowerCaseName')
          ? doc.get('lowerCaseName')
          : '',
      userType:
          doc.data().toString().contains('userType') ? doc.get('userType') : '',
    );
  }
}
