// ignore: file_names
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController dateController;
  // ignore: prefer_typing_uninitialized_variables

  const CustomDatePicker({super.key, required this.dateController});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
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
          controller: widget.dateController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Date',
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 41, 100, 140),
            ),
            suffixIcon: Icon(
              Icons.calendar_month,
              color: Color.fromARGB(255, 41, 100, 140),
            ),
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(
                    2000), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2101));
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('MM-dd-yyyy').format(pickedDate);
              //print(formattedDate);
              setState(
                () {
                  widget.dateController.text = formattedDate;
                },
              );
            } else {
              // ignore: use_build_context_synchronously
              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    backgroundColor: Color.fromARGB(255, 41, 100, 140),
                    title: Text(
                      'Invalided Date!',
                      style: TextStyle(color: Colors.white),
                    ),
                    content: Text(
                      'Date is not selected',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
