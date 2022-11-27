import 'package:flutter/material.dart'; 
import 'textField.dart';

class TextFieldFormWidget extends StatelessWidget {
  final TextEditingController takerNameController;
 final TextEditingController takerIDController;
 
   final positionController = TextEditingController();
  final departmentController = TextEditingController();
  final itemsNameController = TextEditingController();
  final quantityController = TextEditingController();
  final purposeController = TextEditingController();
  final dateController = TextEditingController();
  final campusController = TextEditingController();
  const TextFieldFormWidget({super.key}, this.taker);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputField(
                          keyboardType: TextInputType.text,
                          controller: takerNameController,
                          myhintText: 'Staff Name',
                        ),
                        InputField(
                          keyboardType: TextInputType.number,
                          controller: takerIDController,
                          myhintText: 'ID',
                        ),
                        InputField(
                          keyboardType: TextInputType.text,
                          controller: positionController,
                          myhintText: 'Position',
                        ),
                        InputField(
                          keyboardType: TextInputType.text,
                          controller: departmentController,
                          myhintText: 'Department',
                        ),
                        InputField(
                          keyboardType: TextInputType.text,
                          controller: itemsNameController,
                          myhintText: 'Item Name',
                        ),
                        InputField(
                          keyboardType: TextInputType.number,
                          controller: quantityController,
                          myhintText: 'Quantity',
                        ),
                        InputField(
                          keyboardType: TextInputType.text,
                          controller: purposeController,
                          myhintText: 'Purpose',
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
                              CustomDatePicker(
                                dateController: dateController,
                                function: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(
                                          2000), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101));
                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('MM-dd-yyyy')
                                            .format(pickedDate);
                                    //print(formattedDate);
                                    setState(
                                      () {
                                        dateController.text = formattedDate;
                                      },
                                    );
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          backgroundColor:
                                              Color.fromARGB(255, 41, 100, 140),
                                          title: Text(
                                            'Invalided Date!',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          content: Text(
                                            'Date is not selected',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InputField(
                          keyboardType: TextInputType.text,
                          controller: campusController,
                          myhintText: 'Campus',
                        ),
      ],
    );
  }
}