import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:psutsafe/Controllers/UserController.dart';
import 'package:psutsafe/Screens/ForgotPassword.dart';
import 'package:psutsafe/Screens/Homepage.dart';
import 'package:psutsafe/Screens/SignUpScreen.dart';
import 'package:psutsafe/Services/Auth.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});
  @override
  State<LoginSignupScreen> createState() => _loginSignupScreenState();
}

class _loginSignupScreenState extends State<LoginSignupScreen> {
  String? _id;
  String? _pass;
  String? _token;
  final formKey = GlobalKey<FormState>();
  Auth auth = new Auth();
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('PSUTSafe')),
        backgroundColor: const Color.fromARGB(255, 8, 29, 170),
      ),
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
                        height: 200,
                        child: Image.asset(
                          'Images/LOGO.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Please Enter your Email and Password',
                    style: TextStyle(color: Color.fromARGB(255, 146, 146, 146)),
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
                        return null;
                      },
                      onChanged: (String value) {
                        _id = value;
                        debugPrint(value);
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
                        return null;
                      },
                      onChanged: (String value) {
                        _pass = value;
                        debugPrint(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          bool isValid = await auth.SignIn(_id!, _pass!);
                          if (isValid == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Sign In Successful')),
                            );
                            UserController.updateToken(_token!,
                                FirebaseAuth.instance.currentUser!.uid);
                          } else
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Wrong Email or Password')),
                            );
                        }
                      },
                      child: const Text("Sign In"),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 146, 146, 146),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ForgotPassword()));
                    },
                    child: const Text('Forgot Password?'),
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                      },
                      child: const Text("Sign Up"),
                    ),
                  ),
                  const Text(
                    'Dont have an account? Sign up now!',
                    style: TextStyle(color: Color.fromARGB(255, 146, 146, 146)),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
