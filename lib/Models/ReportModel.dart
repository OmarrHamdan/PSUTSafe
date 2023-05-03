import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  String? id;
  String? creatorId;
  Timestamp? dateReported;
  String? ReportText;
  String? reportImage;

  ReportModel(
      {this.id,
      this.creatorId,
      this.dateReported,
      this.ReportText,
      this.reportImage});

  factory ReportModel.fromDoc(DocumentSnapshot doc) {
    return ReportModel(
      id: doc.id,
      ReportText: doc.data().toString().contains('ReportText')
          ? doc.get('ReportText')
          : '',
      creatorId: doc.data().toString().contains('creatorId')
          ? doc.get('creatorId')
          : '',
      dateReported: doc.data().toString().contains('dateReported')
          ? doc.get('dateReported')
          : '',
      reportImage: doc.data().toString().contains('reportImage')
          ? doc.get('reportImage')
          : '',
    );
  }
}
