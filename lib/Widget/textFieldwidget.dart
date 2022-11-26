import 'package:flutter/material.dart';

class TextFieldForm extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  const TextFieldForm(
      {super.key, required this.controller, required this.hintText, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color.fromARGB(255, 41, 100, 140),
        ),
        icon: Icon(
          icon,
          color: Color.fromARGB(255, 41, 100, 140),
        ),
      ),
    );
  }
}
