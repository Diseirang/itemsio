// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ReportDetails/items_inreportdetails.dart';
import '../UpdatePage/items_in_update.dart';

class ItemsInReport extends StatefulWidget {
  const ItemsInReport({Key? key}) : super(key: key);

  @override
  State<ItemsInReport> createState() => _ItemsInReportState();
}

class _ItemsInReportState extends State<ItemsInReport> {
  Query dbRef = FirebaseDatabase.instance
      .ref()
      .child('itemsin')
      .orderByChild('Date')
      .startAt(DateTime.now());
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('itemsin');
  //Query dbRef = reference.orderByChild("Date");
  Widget listItem({required Map itemsin}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.green,
            blurRadius: 10.0,
            offset: Offset(10, 10),
          ),
        ],
      ),
      child: GestureDetector(
        onDoubleTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ItemsInReportDetails(
                ItemsInDetailKey: itemsin['key'],
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.green[900],
          ),
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          //color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                //padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name : ' + itemsin['StaffName'],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'ID : ' + itemsin['ID'],
                      style: const TextStyle(
                          //fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(
                height: 5,
                thickness: 1,
                color: Colors.grey[350],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Item Desc : ' + itemsin['ItemsDesc'],
                textDirection: TextDirection.ltr,
                maxLines: 2,
                style: const TextStyle(
                    //fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'QTYs : ' + itemsin['Quantity'].toString(),
                    style: const TextStyle(
                        //fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  // Text(
                  //   'Campus : ' + itemsin['Campus'],
                  //   style: const TextStyle(
                  //       //fontSize: 16,
                  //       fontWeight: FontWeight.w400,
                  //       color: Colors.white),
                  // ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UpdateItemsINRecord(
                                ItemsInKey: itemsin['key'],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Column(
                              children: const [
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  //color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                //const Text('Edit'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          //reference.child(itemsin['key']).remove();
                        },
                        child: Row(
                          children: [
                            Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: const [
                                Icon(
                                  Icons.delete,
                                  //color: Colors.red[700],
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                //const Text('Delete'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 5,
              // ),
              // Row(
              //   children: [
              //     Text(
              //       'Purpose : ' + itemsin['Purpose'],
              //       style: const TextStyle(
              //           //fontSize: 16,
              //           fontWeight: FontWeight.w400,
              //           color: Colors.white),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 0,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     // Text(
              //     //   'Date : ' + itemsin['Date'],
              //     //   style: const TextStyle(
              //     //       //fontSize: 16,
              //     //       fontWeight: FontWeight.w400,
              //     //       color: Colors.white),
              //     // ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF29648C),
        title: Text(
          'Items IN Report'.toUpperCase(),
          style:
              GoogleFonts.aclonica(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Scrollbar(
        thickness: 5,
        radius: Radius.circular(10),
        hoverThickness: 20,
        thumbVisibility: true,
        child: Container(
          color: Colors.green[200],
          child: SizedBox(
            height: double.infinity,
            child: FirebaseAnimatedList(
              query: reference.orderByChild("TimeAdded"),
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map itemsin = snapshot.value as Map;
                itemsin['key'] = snapshot.key;

                return listItem(itemsin: itemsin);
              },
            ),
          ),
        ),
      ),
    );
  }
}
