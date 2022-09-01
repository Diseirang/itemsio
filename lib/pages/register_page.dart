import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isHiddenPassword = true;
  bool _isHiddenConfirmPassword = true;
  // Text controller
  final _idCardControl = TextEditingController();
  final _emailControl = TextEditingController();
  final _passwordControl = TextEditingController();
  final _confirmPasswordControl = TextEditingController();
  final _firstNameControl = TextEditingController();
  final _lastNameControl = TextEditingController();
  final _ageControl = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  // ignore: deprecated_member_use
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void dispose() {
    _emailControl.dispose();
    _passwordControl.dispose();
    _confirmPasswordControl.dispose();
    _firstNameControl.dispose();
    _lastNameControl.dispose();
    _ageControl.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (_firstNameControl.text.isNotEmpty &&
        _lastNameControl.text.isNotEmpty &&
        _ageControl.text.isNotEmpty &&
        _idCardControl.text.isNotEmpty &&
        _emailControl.text.isNotEmpty &&
        _passwordControl.text.isNotEmpty) {
      try {
        // if (passwordConfirm()) {
        // create user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailControl.text.trim(),
          password: _passwordControl.text.trim(),
        );
        // add user details
        addUserDetails(
          _firstNameControl.text.trim(),
          _lastNameControl.text.trim(),
          _idCardControl.text.trim(),
          _emailControl.text.trim(),
          int.parse(_ageControl.text.trim()),
        );

        // insert database
        insertDataRealtime(
          _firstNameControl.text.trim(),
          _lastNameControl.text.trim(),
          _idCardControl.text.trim(),
          _emailControl.text.trim(),
          int.parse(_ageControl.text.trim()),
        );
        //}
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                backgroundColor: Color.fromARGB(255, 41, 100, 140),
                title: Text(
                  'Email existed!',
                  style: TextStyle(color: Colors.white),
                ),
                content: Text(
                  'This email address is already in used with another account.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
        } else if (e.code == 'weak-password') {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                backgroundColor: Color.fromARGB(255, 41, 100, 140),
                title: Text(
                  'Password!',
                  style: TextStyle(color: Colors.white),
                ),
                content: Text(
                  'The password provided too weak.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 41, 100, 140),
              content: Text(
                e.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text(
              'Missing details!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color.fromARGB(255, 41, 100, 140),
            content: Text(
              'Please fill the blank textfield to completed your details!',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }
  }

// insert data to Realtime Database
  void insertDataRealtime(
      String firstName, String lastName, String idCard, String email, int age) {
    //String? key = databaseReference.child("UserInfo").push().key;
    databaseReference.child("UserInfo").push().set(
      {
        //'Nº': key,
        'firstName': firstName,
        'lastName': lastName,
        'idCard': idCard,
        'email': email,
        'age': age,
      },
    );
  }

  // Add data to firestore Database
  Future addUserDetails(String firstName, String lastName, String idCard,
      String email, int age) async {
    await FirebaseFirestore.instance.collection('UserInfo').doc(idCard).set(
      {
        'firstName': firstName,
        'lastName': lastName,
        'idCard': idCard,
        'email': email,
        'age': age,
      },
    );
  }

  bool passwordConfirm() {
    if (_passwordControl.text.trim() == _confirmPasswordControl.text.trim()) {
      return true;
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text(
              'Password',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color.fromARGB(255, 41, 100, 140),
            content: Text(
              'Your password do not matched!',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 100, 140),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  // Text Items IO
                  Text(
                    'Items IO',
                    style: GoogleFonts.rubikMoonrocks(
                        fontSize: 23, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 5,
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
                      height: 100,
                      width: 100,
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
                    height: 20,
                  ),
                  // Register Text

                  Text(
                    'Register below with your details!',
                    style:
                        GoogleFonts.pacifico(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // First Name TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 45, 231, 255),
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          ),
                        ],
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 5),
                        child: TextField(
                          controller: _firstNameControl,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 41, 100, 140),
                            ),
                            border: InputBorder.none,
                            hintText: 'Username',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 41, 100, 140),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // // Last Name TextField
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       boxShadow: const [
                  //         BoxShadow(
                  //           color: Color.fromARGB(255, 45, 231, 255),
                  //           blurRadius: 20.0,
                  //           offset: Offset(0, 10),
                  //         ),
                  //       ],
                  //       color: Colors.grey[100],
                  //       border: Border.all(color: Colors.white),
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 20, right: 5),
                  //       child: TextField(
                  //         controller: _lastNameControl,
                  //         keyboardType: TextInputType.text,
                  //         decoration: const InputDecoration(
                  //           border: InputBorder.none,
                  //           hintText: 'Last Name',
                  //           hintStyle: TextStyle(
                  //             color: Color.fromARGB(255, 41, 100, 140),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // const SizedBox(
                  //   height: 10,
                  // ),

                  // // Age TextField
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       boxShadow: const [
                  //         BoxShadow(
                  //           color: Color.fromARGB(255, 45, 231, 255),
                  //           blurRadius: 20.0,
                  //           offset: Offset(0, 10),
                  //         ),
                  //       ],
                  //       color: Colors.grey[100],
                  //       border: Border.all(color: Colors.white),
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 20, right: 5),
                  //       child: TextField(
                  //         controller: _ageControl,
                  //         keyboardType: TextInputType.number,
                  //         decoration: const InputDecoration(
                  //           border: InputBorder.none,
                  //           hintText: 'Age',
                  //           hintStyle: TextStyle(
                  //             color: Color.fromARGB(255, 41, 100, 140),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // const SizedBox(
                  //   height: 10,
                  // ),

                  // // Age TextField
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       boxShadow: const [
                  //         BoxShadow(
                  //           color: Color.fromARGB(255, 45, 231, 255),
                  //           blurRadius: 20.0,
                  //           offset: Offset(0, 10),
                  //         ),
                  //       ],
                  //       color: Colors.grey[100],
                  //       border: Border.all(color: Colors.white),
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 20, right: 5),
                  //       child: TextField(
                  //         controller: _idCardControl,
                  //         keyboardType: TextInputType.text,
                  //         decoration: const InputDecoration(
                  //           border: InputBorder.none,
                  //           hintText: 'ID Card',
                  //           hintStyle: TextStyle(
                  //             color: Color.fromARGB(255, 41, 100, 140),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  const SizedBox(
                    height: 10,
                  ),
                  // Email TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 45, 231, 255),
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          ),
                        ],
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 5),
                        child: TextField(
                          controller: _emailControl,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Color.fromARGB(255, 41, 100, 140),
                            ),
                            border: InputBorder.none,
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 41, 100, 140),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // Password TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 45, 231, 255),
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          ),
                        ],
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 5),
                        child: TextField(
                          controller: _passwordControl,
                          obscureText: _isHiddenPassword,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.key,
                              color: Color.fromARGB(255, 41, 100, 140),
                            ),
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 41, 100, 140),
                            ),
                            suffixIcon: IconButton(
                              splashRadius: 0.1,
                              icon: Icon(
                                _isHiddenPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color.fromARGB(255, 41, 100, 140),
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    _isHiddenPassword = !_isHiddenPassword;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Comfirm Password TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 45, 231, 255),
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          ),
                        ],
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 5),
                        child: TextField(
                          controller: _confirmPasswordControl,
                          obscureText: _isHiddenConfirmPassword,
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.key,
                              color: Color.fromARGB(255, 41, 100, 140),
                            ),
                            border: InputBorder.none,
                            hintText: 'Comfirm password',
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 41, 100, 140),
                            ),
                            suffixIcon: IconButton(
                              splashRadius: 0.1,
                              icon: Icon(
                                _isHiddenConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color.fromARGB(255, 41, 100, 140),
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    _isHiddenConfirmPassword =
                                        !_isHiddenConfirmPassword;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Signin Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: signUp,
                      child: Container(
                        padding: const EdgeInsets.all(15),
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
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.person_add_alt_outlined,
                                color: Colors.white,
                                size: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  // not a member? register now!
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already a memeber?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: const Text(
                          ' Login now!',
                          style: TextStyle(
                            color: Color.fromARGB(255, 67, 255, 111),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50.0,
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
