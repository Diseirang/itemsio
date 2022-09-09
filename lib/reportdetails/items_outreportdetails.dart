// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class itemsOUTReportDetails extends StatefulWidget {
  const itemsOUTReportDetails({Key? key, required this.itemsOUTDetailKey})
      : super(key: key);
  final String itemsOUTDetailKey;
  @override
  State<itemsOUTReportDetails> createState() => _itemsOUTReportDetailsState();
}

class _itemsOUTReportDetailsState extends State<itemsOUTReportDetails> {
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
    dbRef = FirebaseDatabase.instance.ref().child('itemsout');
    getitemsOUTData();
  }

  void getitemsOUTData() async {
    DataSnapshot snapshot = await dbRef.child(widget.itemsOUTDetailKey).get();

    Map itemsOUT = snapshot.value as Map;

    staffNameController.text = itemsOUT['StaffName'];
    idController.text = itemsOUT['ID'];
    positionController.text = itemsOUT['Position'];
    itemDescController.text = itemsOUT['ItemsDesc'];
    purposeController.text = itemsOUT['Purpose'];
    dateController.text = itemsOUT['Date'];
    qtyController.text = itemsOUT['Quantity'].toString();
    campusController.text = itemsOUT['Campus'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: const Color(0xFF29648C),
        title: Text(
          'Report Details'.toUpperCase(),
          style:
              GoogleFonts.aclonica(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'TAKER\'S NAME',
                style: TextStyle(
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              TextField(
                decoration: const InputDecoration(border: InputBorder.none),
                readOnly: true,
                controller: staffNameController,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 2.0,
                  color: Colors.amberAccent[200],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'ID CARD',
                style: TextStyle(
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              TextField(
                decoration: const InputDecoration(border: InputBorder.none),
                readOnly: true,
                controller: idController,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 2.0,
                  color: Colors.amberAccent[200],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'position'.toUpperCase(),
                style: const TextStyle(
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              TextField(
                decoration: const InputDecoration(border: InputBorder.none),
                readOnly: true,
                controller: positionController,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 2.0,
                  color: Colors.amberAccent[200],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'items description'.toUpperCase(),
                style: const TextStyle(
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              TextField(
                decoration: const InputDecoration(border: InputBorder.none),
                readOnly: true,
                controller: itemDescController,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 2.0,
                  color: Colors.amberAccent[200],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'qty'.toUpperCase(),
                style: const TextStyle(
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              TextField(
                decoration: const InputDecoration(border: InputBorder.none),
                readOnly: true,
                controller: qtyController,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 2.0,
                  color: Colors.amberAccent[200],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'purpose'.toUpperCase(),
                style: const TextStyle(
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              TextField(
                decoration: const InputDecoration(border: InputBorder.none),
                readOnly: true,
                controller: purposeController,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 2.0,
                  color: Colors.amberAccent[200],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'Campus'.toUpperCase(),
                style: const TextStyle(
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              TextField(
                decoration: const InputDecoration(border: InputBorder.none),
                readOnly: true,
                controller: campusController,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 2.0,
                  color: Colors.amberAccent[200],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'date'.toUpperCase(),
                style: TextStyle(
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[400]),
              ),
              TextField(
                decoration: const InputDecoration(border: InputBorder.none),
                readOnly: true,
                controller: dateController,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 2.0,
                  color: Colors.amberAccent[200],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
