import 'package:flutter/material.dart';
import 'customDatePicker.dart';
import 'textField.dart';

class TextFieldFormWidget extends StatefulWidget {
  final TextEditingController takerNameController;
  final TextEditingController takerIDController;
  final TextEditingController positionController;
  final TextEditingController departmentController;
  final TextEditingController itemsNameController;
  final TextEditingController quantityController;
  final TextEditingController purposeController;
  final TextEditingController dateController;
  final TextEditingController campusController;

  const TextFieldFormWidget({
    super.key,
    required this.takerNameController,
    required this.takerIDController,
    required this.positionController,
    required this.departmentController,
    required this.itemsNameController,
    required this.quantityController,
    required this.purposeController,
    required this.dateController,
    required this.campusController,
  });

  @override
  State<TextFieldFormWidget> createState() => _TextFieldFormWidgetState();
}

class _TextFieldFormWidgetState extends State<TextFieldFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputField(
          keyboardType: TextInputType.text,
          controller: widget.takerNameController,
          myhintText: 'Staff Name',
        ),
        InputField(
          keyboardType: TextInputType.number,
          controller: widget.takerIDController,
          myhintText: 'ID',
        ),
        InputField(
          keyboardType: TextInputType.text,
          controller: widget.positionController,
          myhintText: 'Position',
        ),
        InputField(
          keyboardType: TextInputType.text,
          controller: widget.departmentController,
          myhintText: 'Department',
        ),
        InputField(
          keyboardType: TextInputType.text,
          controller: widget.itemsNameController,
          myhintText: 'Item Name',
        ),
        InputField(
          keyboardType: TextInputType.number,
          controller: widget.quantityController,
          myhintText: 'Quantity',
        ),
        InputField(
          keyboardType: TextInputType.text,
          controller: widget.purposeController,
          myhintText: 'Purpose',
        ),
        CustomDatePicker(
          dateController: widget.dateController,
        ),
        
        InputField(
          keyboardType: TextInputType.text,
          controller: widget.campusController,
          myhintText: 'Campus',
        ),
      ],
    );
  }
}
