// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // Text controller
  final _emailControl = TextEditingController();

  @override
  void dispose() {
    _emailControl.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      if (_emailControl.text.isNotEmpty) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailControl.text.trim());

        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Color.fromARGB(255, 41, 100, 140),
              title: Text(
                'Alert!',
                style: TextStyle(color: Colors.white),
              ),
              content: Text(
                'Password reset link sent! Check your email.',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
        _emailControl.clear();
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Color.fromARGB(255, 41, 100, 140),
              title: Text(
                'Invalided email!',
                style: TextStyle(color: Colors.white),
              ),
              content: Text(
                'Please enter your email to get password reset link.',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      //print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              e.message.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF29648C),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 41, 100, 140),
        title: Text(
          'Forgot Password?',
          style:
              GoogleFonts.aclonica(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    'Items IO',
                    style: GoogleFonts.rubikMoonrocks(
                        fontSize: 28, color: Colors.white),
                  ),
                  // Logo
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF29648C),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 45, 231, 255),
                          blurRadius: 20.0,
                          offset: Offset(0, 10),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/logo.jpg'),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 45, 231, 255),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Enter your email and we will send you a password reset link!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ), // Email TextField
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 45, 231, 255),
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 10),
                              child: TextFormField(
                                controller: _emailControl,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your email...',
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 41, 100, 140),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: passwordReset,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        height: 60.0,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 45, 231, 255),
                              blurRadius: 20.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                          border: Border.all(color: Colors.white, width: 4),
                          color: const Color(0xFF29648C),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.restore_outlined,
                              size: 25,
                              color: Colors.white,
                            ),
                            Text(
                              'Reset Password',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
