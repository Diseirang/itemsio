// ignore_for_file: non_constant_identifier_names

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UpdateItemsINRecord extends StatefulWidget {
  const UpdateItemsINRecord({Key? key, required this.ItemsInKey})
      : super(key: key);
  final String ItemsInKey;

  @override
  State<UpdateItemsINRecord> createState() => _UpdateItemsINRecordState();
}

class _UpdateItemsINRecordState extends State<UpdateItemsINRecord> {
  final staffNameController = TextEditingController();
  final idController = TextEditingController();
  final positionController = TextEditingController();
  final itemDescController = TextEditingController();
  final qtyController = TextEditingController();
  final purposeController = TextEditingController();
  final dateController = TextEditingController();
  final campusController = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('ItemsIN');
    getItemsINData();
  }

  void getItemsINData() async {
    DataSnapshot snapshot = await dbRef.child(widget.ItemsInKey).get();

    Map itemsIN = snapshot.value as Map;

    staffNameController.text = itemsIN['StaffName'];
    idController.text = itemsIN['ID'];
    itemDescController.text = itemsIN['ItemsDesc'];
    positionController.text = itemsIN['Position'];
    purposeController.text = itemsIN['Purpose'];
    dateController.text = itemsIN['Date'];
    qtyController.text = itemsIN['Quantity'].toString();
    campusController.text = itemsIN['Campus'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF29648C),
        title: Text(
          'updating record'.toUpperCase(),
          style:
              GoogleFonts.aclonica(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'Edit and Update \n Your Data Carfully!',
                  style: TextStyle(
                    color: Color(0xFF29648C),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: staffNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Name',
                    hintText: 'Enter Your Name',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: idController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'ID',
                    hintText: 'Enter Your ID',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: positionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Position',
                    hintText: 'Enter Your Position',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: itemDescController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Item Description',
                    hintText: 'Enter Your Description',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: qtyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Quantity',
                    hintText: 'Enter Your Quantity',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: purposeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Purpose',
                    hintText: 'Enter Your Purpose',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
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
                          dateController.text = formattedDate;
                        },
                      );
                      // } else {
                      //   showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return const AlertDialog(
                      //         backgroundColor: Color.fromARGB(255, 41, 100, 140),
                      //         title: Text(
                      //           'Invalided Date!',
                      //           style: TextStyle(color: Colors.white),
                      //         ),
                      //         content: Text(
                      //           'Date is not selected',
                      //           style: TextStyle(color: Colors.white),
                      //         ),
                      //       );
                      //     },
                      //   );
                    }
                  },
                  controller: dateController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Date',
                    hintText: 'Select Date',
                    suffixIcon: const Icon(
                      Icons.calendar_month,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: campusController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Campus',
                    hintText: 'Enter Your Campus',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: GestureDetector(
                    onTap: () {
                      Map<String, String> itemsIN = {
                        'StaffName': staffNameController.text,
                        'ID': idController.text,
                        'Position': positionController.text,
                        'ItemsDesc': itemDescController.text,
                        'Quantity': qtyController.text,
                        'Purpose': purposeController.text,
                        'Date': dateController.text,
                        'Campus': campusController.text,
                      };

                      dbRef
                          .child(widget.ItemsInKey)
                          .update(itemsIN)
                          .then((value) => {Navigator.pop(context)});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 45, 231, 255),
                            blurRadius: 20.0,
                            offset: Offset(0, 5),
                          ),
                        ],
                        border: Border.all(color: Colors.white, width: 4),
                        color: const Color(0xFF29648C),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.note_alt,
                              color: Colors.white,
                              size: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Update'.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
