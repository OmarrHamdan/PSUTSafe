import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:psutsafe/Controllers/HomeController.dart';
import 'package:psutsafe/Screens/ForgotPassword.dart';
import 'package:psutsafe/Screens/Homepage.dart';
import 'package:psutsafe/Screens/ProfileScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedScreen extends StatefulWidget {
  final String thisUser;
  const FeedScreen({super.key, required this.thisUser});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final number = '911';
  Future<void> openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Important Numbers"),
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
                  launch('tel://$number');
                },
                child: const Text("Police"),
              ),
            ],
          ));
  Future<void> openDialog4() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
                "The closest exit to you should be the IT parking gate, head down the stairs through the school doors and keep going forward until you see the gate on your left, then leave through it"),
            actions: [],
          ));
  Future<void> openDialog6() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
                "Head down the stairs and take the first door to your right, then go up the stairs and take a right, then you will continue forward until you reach the registration gate"),
            actions: [],
          ));
  Future<void> openDialog9() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
                "You have two options, either go down to the ground floor and exit the building to the IT parking gate, or exit the building from the far left side making your way to the jungle and continue forward until you reach the Engineering parking gate"),
            actions: [],
          ));
  Future<void> openDialog16() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
                "There is only one exit to this building, go to the ground floor and leave from the door then take a left to the registration gate"),
            actions: [],
          ));
  Future<void> openDialog10() => showDialog(
      context: context,
      builder: (context) => const AlertDialog(
            title: Text(
                "The nearest exit to you is to make your way to the end of the building by the 340's classrooms and exit from the door, then make your way to the engineering parking gate"),
            actions: [],
          ));
  Future<void> openDialog5() => showDialog(
      context: context,
      builder: (context) => const AlertDialog(
            title: Text(
                "You have two options, either exit the school through its doors and proceed forward until you reach the registration gate, or go down the stairs through the doors and make your way to the IT parking gate"),
            actions: [],
          ));
  Future<void> openDialog19() => showDialog(
      context: context,
      builder: (context) => const AlertDialog(
            title: Text(
                "The closest exit is to leave the building from the main entrance and proceed straight until you reach the registration gate"),
            actions: [],
          ));
  Future<void> openDialog20() => showDialog(
      context: context,
      builder: (context) => const AlertDialog(
            title: Text(
                "The closest exit is to go down the stairs of the stadium and leave from the exit to the IT parking garage then make your way to the IT parking gate"),
            actions: [],
          ));
  Future<void> openDialog14() => showDialog(
      context: context,
      builder: (context) => const AlertDialog(
            title: Text(
                "The closest exit is to reach the ground floor no matter what floor you are on and leave through the doors to the main street"),
            actions: [],
          ));
  Future<void> openDialog17() => showDialog(
      context: context,
      builder: (context) => const AlertDialog(
            title: Text(
                "Make your way to the front of the building no matter where you are, leaving through the doors then go straight then left making your way to the registration gate"),
            actions: [],
          ));
  Future<void> openDialog18() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Where exactly?"),
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
                  Navigator.pop(context);
                  openDialog19();
                },
                child: const Text("Ground floor"),
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
                  Navigator.pop(context);
                  openDialog20();
                },
                child: const Text("Al-Sadaqa Stadium"),
              ),
            ],
          ));
  Future<void> openDialog8() => showDialog(
      context: context,
      builder: (context) => const AlertDialog(
            title: Text(
                "Leave the building then proceed to make your way down to the IT parking gate"),
            actions: [],
          ));
  Future<void> openDialog12() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Which Building?"),
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
                  Navigator.pop(context);
                  openDialog13();
                },
                child: const Text("D"),
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
                  Navigator.pop(context);
                  openDialog14();
                },
                child: const Text("B"),
              ),
            ],
          ));
  Future<void> openDialog11() => showDialog(
      context: context,
      builder: (context) => const AlertDialog(
            title: Text(
                "Leave the building from the exit door then make your way down the stairs and into the engineering park gate"),
            actions: [],
          ));
  Future<void> openDialog15() => showDialog(
      context: context,
      builder: (context) => const AlertDialog(
            title: Text(
                "No matter what floor you are on there are only two exits, either go down to the ground floor leaving from the main entrance and make your way to the registration gate, or from the ground floor leaving from the blue fig door and going to the engineering parking gate"),
            actions: [],
          ));
  Future<void> openDialog21() => showDialog(
      context: context,
      builder: (context) => const AlertDialog(
            title: Text(
                "The closest exit is to go down to the IT parking garage through the IT park gate which is next to the RSS gate itself"),
            actions: [],
          ));
  Future<void> openDialog13() => showDialog(
      context: context,
      builder: (context) => const AlertDialog(
            title: Text(
                "No matter which floor you are on, there are only two ways to exit, either leaving building by going to the ground floor door and make your way up the stairs to the IT parking gate, or after leaving the building take a right and leave through the exit in the B building"),
            actions: [],
          ));
  Future<void> openDialog7() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Where Exactly?"),
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
                  Navigator.pop(context);
                  openDialog8();
                },
                child: const Text("Ground Floor"),
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
                  Navigator.pop(context);
                  openDialog9();
                },
                child: const Text("First Floor"),
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
                  Navigator.pop(context);
                  openDialog10();
                },
                child: const Text("Second Floor"),
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
                  Navigator.pop(context);
                  openDialog11();
                },
                child: const Text("Third Floor"),
              ),
            ],
          ));
  Future<void> openDialog3() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Where Exactly?"),
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
                  Navigator.pop(context);
                  openDialog4();
                },
                child: const Text("First Floor"),
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
                  Navigator.pop(context);
                  openDialog5();
                },
                child: const Text("Second Floor"),
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
                  Navigator.pop(context);
                  openDialog6();
                },
                child: const Text("Third Floor"),
              ),
            ],
          ));
  Future<void> openDialog2() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Where are you currently?"),
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
                  Navigator.pop(context);
                  openDialog3();
                },
                child: const Text("IT"),
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
                  Navigator.pop(context);
                  openDialog7();
                },
                child: const Text("Engineering"),
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
                  Navigator.pop(context);
                  openDialog12();
                },
                child: const Text("Business"),
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
                  Navigator.pop(context);
                  openDialog15();
                },
                child: const Text("Deanship"),
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
                  Navigator.pop(context);
                  openDialog16();
                },
                child: const Text("Higher Studies"),
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
                  Navigator.pop(context);
                  openDialog17();
                },
                child: const Text("Registration"),
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
                  Navigator.pop(context);
                  openDialog18();
                },
                child: const Text("Administration"),
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
                  Navigator.pop(context);
                  openDialog21();
                },
                child: const Text("RSS"),
              ),
            ],
          ));

  int _selectedTab = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
            heroTag: "btn1",
            backgroundColor: Colors.white,
            foregroundColor: Color.fromARGB(255, 8, 29, 170),
            onPressed: () {
              openDialog2();
            },
            child: const Icon(Icons.directions_walk)),
        const SizedBox(
          height: 10,
        ),
        FloatingActionButton(
            heroTag: "btn2",
            backgroundColor: Colors.white,
            foregroundColor: Color.fromARGB(255, 8, 29, 170),
            onPressed: () {
              openDialog();
            },
            child: const Icon(Icons.phone)),
      ]),
      body: PageView(
        physics: const ScrollPhysics(
          parent: RangeMaintainingScrollPhysics(),
        ),
        controller: _pageController,
        onPageChanged: (page) {
          if (mounted) {
            setState(() {
              _selectedTab = page;
            });
          }
        },
        children: <Widget>[
          HomePage(
            thisUser: widget.thisUser,
          ),
          ProfileScreen(
              thisUser: widget.thisUser, visitingAdmin: widget.thisUser)
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        animationCurve: Curves.easeOutQuad,
        color: Color.fromARGB(255, 8, 29, 170),
        index: _selectedTab,
        onTap: (value) {
          _selectedTab = value;
          _pageController.animateToPage(
            value,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
          if (mounted) {
            setState(() {});
          }
        },
        letIndexChange: (index) => true,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.white,
        items: const [
          Icon(Icons.home_outlined),
          Icon(Icons.person_2_outlined),
        ],
      ),
    );
  }
}
