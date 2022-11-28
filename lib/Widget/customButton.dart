// ignore: file_names
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String buttonText;
  const CustomButtonWidget({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Color.fromARGB(255, 45, 231, 255),
              blurRadius: 20.0,
              offset: Offset(0, 5)),
        ],
        border: Border.all(color: Colors.white, width: 2),
        color: const Color(0xFF29648C),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.save_as_outlined,
            size: 25,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
