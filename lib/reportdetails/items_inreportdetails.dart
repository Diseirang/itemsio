// ignore_for_file: non_constant_identifier_names
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemsInReportDetails extends StatefulWidget {
  const ItemsInReportDetails({Key? key, required this.ItemsInDetailKey})
      : super(key: key);
  final String ItemsInDetailKey;

  @override
  State<ItemsInReportDetails> createState() => _ItemsInReportDetailsState();
}

class _ItemsInReportDetailsState extends State<ItemsInReportDetails> {
  final staffNameController = TextEditingController();
  final idController = TextEditingController();
  final positionController = TextEditingController();
  final itemDescController = TextEditingController();
  final qtyController = TextEditingController();
  final purposeController = TextEditingController();
  final dateController = TextEditingController();
  final campusController = TextEditingController();

  late DatabaseReference dbRef;

  get itemsIN => null;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('itemsin');
    getItemsINData();
  }

  void getItemsINData() async {
    DataSnapshot snapshot = await dbRef.child(widget.ItemsInDetailKey).get();

    Map itemsIN = snapshot.value as Map;

    staffNameController.text = itemsIN['StaffName'];
    idController.text = itemsIN['ID'];
    positionController.text = itemsIN['Position'];
    itemDescController.text = itemsIN['ItemsDesc'];
    purposeController.text = itemsIN['Purpose'];
    dateController.text = itemsIN['Date'];
    qtyController.text = itemsIN['Quantity'].toString();
    campusController.text = itemsIN['Campus'];
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
              const SizedBox(
                height: 5.0,
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
