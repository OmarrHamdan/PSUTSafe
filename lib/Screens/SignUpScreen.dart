import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:psutsafe/Services/Auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? _firstname;
  String? _lastname;
  String? _email;
  String? _number;
  String? _major;
  late List _mc;
  String? _id;
  String? _usertype;
  String? _pass;
  String? _token;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          await FirebaseMessaging.instance.getToken().then((value) => {
                setState(() {
                  _token = value as String;
                })
              });
        } catch (e) {}
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Container(
                          height: 160,
                          child: Image.asset(
                            'Images/LOGO.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'First Name',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill this field';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          _firstname = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Last Name',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill this field';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          _lastname = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill this field';
                          }
                          if (!value.contains('@')) {
                            return 'Incorrect Email format';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          _email = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            hintText: 'Phone Number',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill this field';
                          }
                          if (value.length != 10) {
                            return 'Phone number must be 10 digits';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          _number = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Major',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill this field';
                          }

                          return null;
                        },
                        onChanged: (String value) {
                          _major = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Medical Condition(s)',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white),
                        onChanged: (String value) {
                          _mc = value
                              .split(',')
                              .map((_mc) => _mc.trim())
                              .toList();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'User type ex.Student,Visitor,Teacher..',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill this field';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          _usertype = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'University ID',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill this field';
                          }
                          if (value.length != 8) {
                            return 'ID must be 8 digits starting with 20';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          _id = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: TextFormField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill this field';
                          }
                          if (value.length < 6) {
                            return 'Password must be 6 characters or more';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          _pass = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 8, 29, 170)),
                          maximumSize:
                              MaterialStateProperty.all<Size>(Size.infinite),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size.fromHeight(40)),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Auth().SignUp(
                                _firstname!,
                                _lastname!,
                                _email!,
                                _number!,
                                _major!,
                                _mc,
                                _usertype!,
                                _id!,
                                _pass!,
                                _token!);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Sign Up Successful')),
                            );
                          }
                        },
                        child: const Text("Sign Up"),
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
