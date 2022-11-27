import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController dateController;
  // ignore: prefer_typing_uninitialized_variables
  final function;
  const CustomDatePicker({super.key, required this.dateController, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: TextField(
                                    keyboardType: TextInputType.none,
                                    controller: dateController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Date',
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 41, 100, 140),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.calendar_month,
                                        color:
                                            Color.fromARGB(255, 41, 100, 140),
                                      ),
                                    ),
                                    onTap: function,
                                  ),
                                ),
                              );
  }
  
   
}