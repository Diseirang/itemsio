import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'About Developer'.toUpperCase(),
            style:
                GoogleFonts.aclonica(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF29648C),
        ),
      );
}
