import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
  final itemsNametroller = TextEditingController();
  final quantityController = TextEditingController();
  final perposeController = TextEditingController();
  final dateController = TextEditingController();
  final campusController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  // ignore: deprecated_member_use
  final databaseReference = FirebaseDatabase.instance.reference();
  // Get current user email
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void dispose() {
    takerNameController.dispose();
    takerIDController.dispose();
    positionController.dispose();
    departmentController.dispose();
    itemsNametroller.dispose();
    quantityController.dispose();
    perposeController.dispose();
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
        .collection('ItemsOUT')
        .doc(campus + DateTime.now().toString())
        .set(
      {
        'CurrentUser': user.email!,
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
    databaseReference.child("ItemsOUT").push().set(
      {
        //'Nº': key,
        'CurrentUser': user.email!,
        'StaffName': takerName,
        'ID': takerID,
        'Position': position,
        'Department': division,
        'ItemsDesc': itemName,
        'Quantity': quantity,
        'Purpose': perpose,
        'Date': date,
        'TimeAdded': time,
        'Campus': campus
      },
    );
    takerNameController.clear();
    takerIDController.clear();
    positionController.clear();
    departmentController.clear();
    itemsNametroller.clear();
    quantityController.clear();
    perposeController.clear();
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
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 41, 100, 140),
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextField(
                                  controller: takerNameController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Staff Name',
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 41, 100, 140),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextField(
                                  controller: takerIDController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'ID',
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 41, 100, 140),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextField(
                                  controller: positionController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Position',
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 41, 100, 140),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextField(
                                  controller: departmentController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Department',
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 41, 100, 140),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextField(
                                  controller: itemsNametroller,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Item Name',
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 41, 100, 140),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextField(
                                  controller: quantityController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Quantity',
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 41, 100, 140),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextField(
                                  controller: perposeController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Purpose',
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 41, 100, 140),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextField(
                                  controller: dateController,
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
                                          DateFormat('MM-dd-yyyy')
                                              .format(pickedDate);
                                      //print(formattedDate);
                                      setState(
                                        () {
                                          dateController.text = formattedDate;
                                        },
                                      );
                                    } else {}
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextField(
                                  controller: campusController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Campus',
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 41, 100, 140),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(255, 45, 231, 255),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 5)),
                            ],
                            border: Border.all(color: Colors.white, width: 4),
                            color: const Color(0xFF29648C),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.save_as_outlined,
                                size: 25,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          if (takerIDController.text.isNotEmpty &&
                              takerIDController.text.isNotEmpty &&
                              positionController.text.isNotEmpty &&
                              departmentController.text.isNotEmpty &&
                              itemsNametroller.text.isNotEmpty &&
                              quantityController.text.isNotEmpty &&
                              perposeController.text.isNotEmpty &&
                              dateController.text.isNotEmpty &&
                              campusController.text.isNotEmpty) {
                            try {
                              // Insert Items OUT to Firestore database
                              // insertItemsOUTFirestore(
                              //     takerNameController.text.trim(),
                              //     takerIDController.text.trim(),
                              //     positionController.text.trim(),
                              //     departmentController.text.trim(),
                              //     itemsNametroller.text.trim(),
                              //     int.parse(quantityController.text.trim()),
                              //     perposeController.text.trim(),
                              //     dateController.text.trim(),
                              //     campusController.text.trim(),
                              //     DateTime.now().toString());

                              // Insert Items OUT to Realtime database
                              insertItemsOUTRealtime(
                                  takerNameController.text.trim(),
                                  takerIDController.text.trim(),
                                  positionController.text.trim(),
                                  departmentController.text.trim(),
                                  itemsNametroller.text.trim(),
                                  int.parse(quantityController.text.trim()),
                                  perposeController.text.trim(),
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
