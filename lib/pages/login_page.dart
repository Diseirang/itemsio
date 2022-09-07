import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Provider/google_sign_in.dart';
import 'forgotpassword_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final textStyle = TextStyle();

  bool _isHiddenPassword = true;
  // Text controller
  final _emailControl = TextEditingController();
  final _passwordControl = TextEditingController();
  // signin action
  Future signin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailControl.text.trim(),
        password: _passwordControl.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 41, 100, 140),
            title: const Text(
              'Invalided Details...!',
              style: TextStyle(color: Colors.white),
            ),
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
  void dispose() {
    _emailControl.dispose();
    _passwordControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
          //backgroundColor: const Color.fromARGB(255, 41, 100, 140),
          body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 148, 211, 253),
                  Color.fromARGB(255, 106, 191, 248),
                  Color.fromARGB(255, 62, 144, 199),
                  Color.fromARGB(255, 41, 100, 140),
                ],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 40.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                        )
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
                    height: 10.0,
                  ),
                  // Hello Again
                  Text(
                    'Hello IT Guys!',
                    style: GoogleFonts.bebasNeue(
                        fontSize: 40, color: Colors.white),
                  ),
                  Text(
                    'Welcome back, you\'ve been missed!',
                    style:
                        GoogleFonts.pacifico(color: Colors.white, fontSize: 20),
                  ),
                  // Email TextField
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Email',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
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
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 10),
                                  child: TextField(
                                    controller: _emailControl,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter your Email',
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 41, 100, 140),
                                      ),
                                      icon: Icon(
                                        Icons.mail,
                                        color:
                                            Color.fromARGB(255, 41, 100, 140),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          'Password',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
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
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 10),
                                  child: TextField(
                                    controller: _passwordControl,
                                    obscureText: _isHiddenPassword,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter your Password',
                                      hintStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 41, 100, 140),
                                      ),
                                      suffixIcon: IconButton(
                                        splashRadius: 0.1,
                                        icon: Icon(
                                          _isHiddenPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: const Color.fromARGB(
                                              255, 41, 100, 140),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isHiddenPassword =
                                                !_isHiddenPassword;
                                          });
                                        },
                                      ),
                                      icon: const Icon(
                                        Icons.key,
                                        color:
                                            Color.fromARGB(255, 41, 100, 140),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ForgotPasswordPage();
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),

                  // Signin Button
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: GestureDetector(
                      onTap: signin,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(255, 45, 231, 255),
                                blurRadius: 20.0,
                                offset: Offset(0, 5)),
                          ],
                          border: Border.all(color: Colors.white, width: 2),
                          color: const Color(0xFF29648C),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.login_outlined,
                                size: 25,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Sign In'.toUpperCase(),
                                style: const TextStyle(
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
                  const Text(
                    '- OR -',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Sign in with',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(255, 45, 231, 255),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 5)),
                            ],
                            border: Border.all(color: Colors.white, width: 2),
                            color: const Color(0xFF29648C),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: IconButton(
                            icon: Image.asset('assets/images/google_logo.png'),
                            //iconSize: 50,
                            onPressed: () {
                              final provider =
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);
                              provider.googleLogin();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(255, 45, 231, 255),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 5)),
                            ],
                            border: Border.all(color: Colors.white, width: 2),
                            color: const Color(0xFF29648C),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: IconButton(
                            icon:
                                Image.asset('assets/images/facebook_logo.png'),
                            //iconSize: 50,
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(255, 45, 231, 255),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 5)),
                            ],
                            border: Border.all(color: Colors.white, width: 2),
                            color: const Color(0xFF29648C),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: IconButton(
                            icon: Image.asset('assets/images/twitter_logo.png'),
                            //iconSize: 50,
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  // not a member? register now!
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: const Text(
                          ' Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 25.0, right: 25.0, top: 15.0),
                  //   child: Container(
                  //     padding: const EdgeInsets.all(5),
                  //     decoration: BoxDecoration(
                  //       boxShadow: const [
                  //         BoxShadow(
                  //             color: Color.fromARGB(255, 45, 231, 255),
                  //             blurRadius: 20.0,
                  //             offset: Offset(0, 5)),
                  //       ],
                  //       border: Border.all(color: const Color(0xFF29648C)),
                  //       color: const Color(0xFF29648C),
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     child: ElevatedButton.icon(
                  //       style: ElevatedButton.styleFrom(
                  //         shadowColor: Colors.white,
                  //         primary: Colors.white,
                  //         onPrimary: const Color(0xFF29648C),
                  //         minimumSize: const Size(double.infinity, 50),
                  //       ),
                  //       icon: const FaIcon(
                  //         FontAwesomeIcons.google,
                  //         color: Colors.red,
                  //       ),
                  //       onPressed: () {
                  //         final provider = Provider.of<GoogleSignInProvider>(
                  //             context,
                  //             listen: false);
                  //         provider.googleLogin();
                  //       },
                  //       label: const Text(
                  //         'Sign In with Google',
                  //         style: TextStyle(fontSize: 24),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
