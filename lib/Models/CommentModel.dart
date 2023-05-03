import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  String? id;
  String? commentCreator;
  Timestamp? commentDate;
  String? commentText;

  ReportModel({
    this.id,
    this.commentCreator,
    this.commentDate,
    this.commentText,
  });

  factory ReportModel.fromDoc(DocumentSnapshot doc) {
    return ReportModel(
      id: doc.id,
      commentText: doc.data().toString().contains('commentText')
          ? doc.get('commentText')
          : '',
      commentCreator: doc.data().toString().contains('commentCreator')
          ? doc.get('commentCreator')
          : '',
      commentDate: doc.data().toString().contains('commentDate')
          ? doc.get('commentDate')
          : '',
    );
  }
}
