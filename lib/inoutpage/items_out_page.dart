import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:items_io/Widget/customButton.dart';

import '../Widget/textFieldFormWidget.dart';

class ItemsOutPage extends StatefulWidget {
  const ItemsOutPage({super.key});

  @override
  State<ItemsOutPage> createState() => _ItemsOutPageState();
}

class _ItemsOutPageState extends State<ItemsOutPage> {
  final takerNameController = TextEditingController();
  final takerIDController = TextEditingController();
  final positionController = TextEditingController();
  final departmentController = TextEditingController();
  final itemsNameController = TextEditingController();
  final quantityController = TextEditingController();
  final purposeController = TextEditingController();
  final dateController = TextEditingController();
  final campusController = TextEditingController();

  ///////////FirebaseAuth auth = FirebaseAuth.instance;
  // ignore: deprecated_member_use
  ///////////final databaseReference = FirebaseDatabase.instance.reference();
  // Get current user email
  ///////////final user = FirebaseAuth.instance.currentUser!;
  @override
  void dispose() {
    takerNameController.dispose();
    takerIDController.dispose();
    positionController.dispose();
    departmentController.dispose();
    itemsNameController.dispose();
    quantityController.dispose();
    purposeController.dispose();
    dateController.dispose();
    campusController.dispose();
    super.dispose();
  }

  int i = 0;

  Future insertItemsOUTFirestore(
      String takerName,
      String takerID,
      String position,
      String division,
      String itemName,
      int quantity,
      String perpose,
      String date,
      String campus,
      String time) async {
    await FirebaseFirestore.instance
        .collection('itemsout')
        .doc(campus + DateTime.now().toString())
        .set(
      {
        //'CurrentUser': user.email!,
        'Staff_Name': takerName,
        'ID': takerID,
        'Position': position,
        'Department': division,
        'Items_Name': itemName,
        'Quantity': quantity,
        'Purpose': perpose,
        'Date': date,
        'TimeAdded': time,
        'Campus': campus
      },
    );
  }

  // Insert Data to Items OUT Realtime database
  void insertItemsOUTRealtime(
      String takerName,
      String takerID,
      String position,
      String division,
      String itemName,
      int quantity,
      String perpose,
      String date,
      String campus,
      String time) {
    // String? key = databaseReference.child("ItemsOUT").child(campus) .child(takerID)        .push()        .key;
    // databaseReference.child("itemsout").push().set(
    //   {
    //     //'Nº': key,
    //     'CurrentUser': user.email!,
    //     'StaffName': takerName,
    //     'ID': takerID,
    //     'Position': position,
    //     'Department': division,
    //     'ItemsDesc': itemName,
    //     'Quantity': quantity,
    //     'Purpose': perpose,
    //     'Date': date,
    //     'TimeAdded': time,
    //     'Campus': campus
    //   },
    // );
    takerNameController.clear();
    takerIDController.clear();
    positionController.clear();
    departmentController.clear();
    itemsNameController.clear();
    quantityController.clear();
    purposeController.clear();
    dateController.clear();
    campusController.clear();
  }

  @override
  void initState() {
    dateController.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          padding: const EdgeInsets.only(left: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: Text(
          'Items Out'.toUpperCase(),
          style:
              GoogleFonts.aclonica(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: <Widget>[
                      TextFieldFormWidget(
                        takerNameController: takerNameController,
                        takerIDController: takerIDController,
                        positionController: positionController,
                        departmentController: departmentController,
                        itemsNameController: itemsNameController,
                        quantityController: quantityController,
                        purposeController: purposeController,
                        dateController: dateController,
                        campusController: campusController,
                      ),
                      GestureDetector(
                        child: const CustomButtonWidget(
                          buttonText: 'Save',
                        ),
                        onTap: () {
                          if (takerIDController.text.isNotEmpty &&
                              takerIDController.text.isNotEmpty &&
                              positionController.text.isNotEmpty &&
                              departmentController.text.isNotEmpty &&
                              itemsNameController.text.isNotEmpty &&
                              quantityController.text.isNotEmpty &&
                              purposeController.text.isNotEmpty &&
                              dateController.text.isNotEmpty &&
                              campusController.text.isNotEmpty) {
                            try {
                              // Insert Items OUT to Firestore database
                              insertItemsOUTFirestore(
                                  takerNameController.text.trim(),
                                  takerIDController.text.trim(),
                                  positionController.text.trim(),
                                  departmentController.text.trim(),
                                  itemsNameController.text.trim(),
                                  int.parse(quantityController.text.trim()),
                                  purposeController.text.trim(),
                                  dateController.text.trim(),
                                  campusController.text.trim(),
                                  DateTime.now().toString());

                              // Insert Items OUT to Realtime database
                              insertItemsOUTRealtime(
                                  takerNameController.text.trim(),
                                  takerIDController.text.trim(),
                                  positionController.text.trim(),
                                  departmentController.text.trim(),
                                  itemsNameController.text.trim(),
                                  int.parse(quantityController.text.trim()),
                                  purposeController.text.trim(),
                                  dateController.text.trim(),
                                  campusController.text.trim(),
                                  DateTime.now().toString());
                            } on FirebaseException catch (e) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        const Color.fromARGB(255, 41, 100, 140),
                                    title: const Text(
                                      'Data not filled!',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: Text(
                                      e.message.toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  );
                                },
                              );
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  backgroundColor:
                                      Color.fromARGB(255, 41, 100, 140),
                                  title: Text(
                                    'Data not filled!',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: Text(
                                    'You are not allowed to save either you filled all data!',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFF29648C),
    );
  }
}
