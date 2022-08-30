import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutSystem extends StatelessWidget {
  const AboutSystem({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'About System'.toUpperCase(),
            style:
                GoogleFonts.aclonica(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF29648C),
        ),
      );
}
