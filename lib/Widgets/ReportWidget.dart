import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:psutsafe/Controllers/UserController.dart';
import 'package:psutsafe/Models/ReportModel.dart';
import 'package:psutsafe/Models/UserModel.dart';
import 'package:intl/intl.dart';
import 'package:psutsafe/Screens/CommentScreen.dart';
import 'package:psutsafe/Screens/ProfileScreen.dart';

class ReportWidget extends StatefulWidget {
  final ReportModel report;
  final String thisUser;
  const ReportWidget({
    super.key,
    required this.report,
    required this.thisUser,
  });

  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  Future<void> openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            actions: [
              Image.network(
                widget.report.reportImage!,
              ),
            ],
          ));

  buildTime(ReportModel report) {
    var timeMillisec = report.dateReported?.millisecondsSinceEpoch;
    DateTime reportTime = DateTime.fromMillisecondsSinceEpoch(timeMillisec!);
    var clockTime;

    var difference = DateTime.now().difference(reportTime);
    if (difference.inHours < 24) {
      clockTime = DateFormat('hh:mm').format(reportTime);
    } else {
      clockTime = DateFormat('dd/MM/yyyy').format(reportTime);
    }
    var clockToString = clockTime.toString();

    return Text(
      clockToString as String,
      style: const TextStyle(fontSize: 15, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserController.getUser(widget.report.creatorId!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserModel user = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    255,
                    8,
                    29,
                    170,
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            UserModel admin =
                                await UserController.getUser(widget.thisUser);

                            if (admin.adminOrNot == true) {
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(
                                    thisUser: widget.report.creatorId!,
                                    visitingAdmin: widget.thisUser,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Center(
                            child: user.profilePicture != ""
                                ? CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(user.profilePicture!),
                                    radius: 25)
                                : const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('Images/NoUserImage.png'),
                                    radius: 25),
                          ),
                        ),
                        Column(
                          children: [
                            Text('  ' + user.firstname! + ' ' + user.lastname!,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white)),
                            buildTime(widget.report),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => openDialog(),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            width: 80,
                            height: 80,
                            child: Image.network(
                              widget.report.reportImage!,
                              width: 90,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Text(widget.report.ReportText!,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white)),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 100,
                            width: 100,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Reports')
                                  .doc(widget.report.id)
                                  .collection('Comments')
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CommentScreen()),
                                          ),
                                          child: Text(
                                            snapshot.data.docs.length
                                                    .toString() +
                                                " Comments ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Text('no user');
      },
    );
  }
}
