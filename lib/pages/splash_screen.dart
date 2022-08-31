import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Auth/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetoHome();
  }

  _navigatetoHome() async {
    /////
    await Future.delayed(const Duration(milliseconds: 5000), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 100, 140),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
              height: 5,
            ),
            Text(
              'Items IO',
              style:
                  GoogleFonts.rubikMoonrocks(fontSize: 30, color: Colors.white),
            ),
            const SizedBox(
              height: 100,
            ),
            const CircularProgressIndicator(),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Loading...',
              style: GoogleFonts.pacifico(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
