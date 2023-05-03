import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:psutsafe/Screens/ForgotPassword.dart';
import 'package:psutsafe/Screens/SignUpScreen.dart';
import 'package:psutsafe/Services/Auth.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  @override
  State<ForgotPassword> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPassword> {
  late String _email;
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
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
                        height: 200,
                        child: Image.asset(
                          'Images/LOGO.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const Text('Reset Password',
                      style: TextStyle(color: Colors.white, fontSize: 25)),
                  const SizedBox(
                    height: 30,
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
                    height: 10,
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
                          auth.sendPasswordResetEmail(email: _email);
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Request Sent Successfully')));
                        }
                      },
                      child: const Text("Send Request"),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
