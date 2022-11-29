// ignore: file_names
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String myhintText;
  const InputField({
    super.key,
    required this.keyboardType,
    required this.controller,
    required this.myhintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: TextField(
                keyboardType: keyboardType,
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: myhintText,
                  hintStyle: const TextStyle(
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
      ],
    );
  }
}
