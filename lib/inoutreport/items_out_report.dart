// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ReportDetails/items_outreportdetails.dart';
import '../UpdatePage/items_out_update.dart';

class ItemsOutReport extends StatefulWidget {
  const ItemsOutReport({Key? key}) : super(key: key);

  @override
  State<ItemsOutReport> createState() => _ItemsOutReportState();
}

class _ItemsOutReportState extends State<ItemsOutReport> {
  // Query dbRef = FirebaseDatabase.instance
  //     .ref()
  //     .child('ItemsOUT')
  //     .orderByChild('TimeAdded');
  //.orderByChild('Date')
  //.startAt(DateTime.now());
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('itemsout');
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
              builder: (_) => itemsOUTReportDetails(
                itemsOUTDetailKey: itemsin['key'],
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
              const SizedBox(
                height: 5,
              ),
              Divider(
                height: 10,
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
                  //       fontSize: 16,
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
                              builder: (_) => UpdateItemsOutRecord(
                                ItemsOutKey: itemsin['key'],
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
                  )
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
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  final ScrollController _scrollbarController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF29648C),
        title: Text(
          'Items out Report'.toUpperCase(),
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
      // body: Scrollbar(
      //   controller: _scrollbarController,
      //   thickness: 5,
      //   thumbVisibility: true,
      //   radius: const Radius.circular(10),
      //   child: Container(
      //     color: Colors.green[200],
      //     child: SizedBox(
      //       height: double.infinity,
      //       child: FirebaseAnimatedList(
      //         query: reference.orderByChild("TimeAdded"),
      //         itemBuilder: (BuildContext context, DataSnapshot snapshot,
      //             Animation<double> animation, int index) {
      //           Map itemsin = snapshot.value as Map;
      //           itemsin['key'] = snapshot.key;

      //           return listItem(itemsin: itemsin);
      //         },
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
