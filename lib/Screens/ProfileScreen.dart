import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:psutsafe/Controllers/UserController.dart';
import 'package:psutsafe/Models/ReportModel.dart';
import 'package:psutsafe/Models/UserModel.dart';
import 'package:psutsafe/Widgets/ReportWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfileScreen extends StatefulWidget {
  final String thisUser;
  final String visitingAdmin;
  const ProfileScreen(
      {super.key, required this.thisUser, required this.visitingAdmin});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String lat;
  late String long;

  String _reportImage = '';
  bool _imageUploaded = false;

  List allReports = [];
  List Reports = [];
  UserModel? _user;
  void addProfilePic() async {
    if (_imageUploaded != '') {
      String profilePic = _reportImage;
      UserController.addProfilePic(profilePic, widget.thisUser);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(milliseconds: 2250),
        content: Text("Please fill all the fields and the Image"),
      ));
    }
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
                    borderRadius: BorderRadius.circular(10.0),
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
                    borderRadius: BorderRadius.circular(10.0),
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
    Reference refImagetoupload =
        referenceDirImages.child("profilePics").child(uniqueFileName);

    try {
      await refImagetoupload.putFile(File(file!.path));
      _reportImage = await refImagetoupload.getDownloadURL();
      _imageUploaded = true;
      addProfilePic();
      if (mounted) {
        setState(() {});
      }
    } catch (error) {
      print('object');
    }
  }

  Future<void> openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Are you sure you want to Logout?"),
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
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
                child: const Text("Logout"),
              ),
            ],
          ));
  getAllReports() async {
    allReports = await UserController.getAllReports(widget.thisUser);
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

  getall() async {
    _user = await UserController.getUser(widget.thisUser);
    await getAllReports();
    await combinePostsToOneList();
    if (mounted) setState(() {});
  }

  Future<Position> getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }
    return await Geolocator.getCurrentPosition();
  }

  void liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
    });
  }

  Future<void> openMap(String lat, String long) async {
    String googleURL =
        'https:www.google.com/maps/search/?api=1&query=$lat,$long';

    await launchUrlString(googleURL);
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
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(left: 47),
              child: Center(
                child: Text(
                  'Profile',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                  onPressed: () {
                    openDialog();
                  },
                  icon: const Icon(Icons.logout))
            ],
          )),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                future: UserController.getUser(widget.thisUser),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    UserModel user = snapshot.data!;
                    var x = MediaQuery.of(context).size.width * 0.6;
                    List medicalConditions = user.medicalCondition!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 190,
                          color: Color.fromARGB(255, 8, 29, 170),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onDoubleTap: () =>
                                    widget.thisUser == widget.visitingAdmin
                                        ? UserController.addProfilePic(
                                            "", widget.thisUser)
                                        : null,
                                onTap: widget.thisUser == widget.visitingAdmin
                                    ? uploadPicture
                                    : null,
                                child: Center(
                                  child: user.profilePicture != ""
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              user.profilePicture!),
                                          radius: 45)
                                      : const CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'Images/NoUserImage.png'),
                                          radius: 45),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    if (medicalConditions.isNotEmpty)
                                      Text(
                                          user.firstname! +
                                              ' ' +
                                              user.lastname! +
                                              '!!',
                                          style: const TextStyle(
                                              fontSize: 25,
                                              color: Colors.white)),
                                    if (medicalConditions.isEmpty)
                                      Text(
                                          user.firstname! +
                                              ' ' +
                                              user.lastname!,
                                          style: const TextStyle(
                                              fontSize: 25,
                                              color: Colors.white)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Text(user.uniId!,
                                        style: const TextStyle(
                                            fontSize: 25, color: Colors.white)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Text(user.userType!,
                                        style: const TextStyle(
                                            fontSize: 25, color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Center(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 8, 29, 170)),
                                  maximumSize: MaterialStateProperty.all<Size>(
                                      Size.infinite),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      const Size.fromHeight(40)),
                                ),
                                onPressed: () {
                                  getUserLocation().then((value) {
                                    lat = '${value.latitude}';
                                    long = '${value.longitude}';
                                    openMap(lat, long);
                                    liveLocation();
                                  });
                                },
                                child: const Text('Get User Location',
                                    style: TextStyle(
                                      fontSize: 17,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Text(
                            'Medical Conditions: ',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: medicalConditions.length * 40,
                          child: ListView.builder(
                            itemCount: medicalConditions.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          '-',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          medicalConditions[index],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Column(
                          children: [...Reports],
                        )
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
