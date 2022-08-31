// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportMember extends StatefulWidget {
  const ReportMember({super.key});

  @override
  State<ReportMember> createState() => _ReportMemberState();
}

class _ReportMemberState extends State<ReportMember> {
  Query dbRef = FirebaseDatabase.instance.ref().child('UserInfo');
  //.orderByChild('Date')
  //.startAt(DateTime.now());
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('UserInfo');
  Widget listUser({required Map userInfo}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 45, 231, 255),
            blurRadius: 20.0,
            offset: Offset(10, 10),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFF29648C),
        ),
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        //color: Colors.white,
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      userInfo['firstName'] + ' ' + userInfo['lastName'],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'ID : ' + UserInfo['idCard'],
                //       style: const TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.white),
                //     ),
                //     const SizedBox(
                //       width: 5,
                //     ),
                //     //Text(033333333333333333333333333333333333333333333333333333333333333333333333333333333333330000000000000000000000000000000000000000000000000000000000
                //     //                                      00 'Age : ${UserInfo['age']}',
                //     //  style: const TextStyle(
                //     //      fontSize: 18,
                //     //      fontWeight: FontWeight.bold,
                //     //      color: Colors.white),
                //     //),
                //   ],
                // ),
              ],
            ),
            Row(
              children: [
                Text(
                  userInfo["email"],
                  style: const TextStyle(
                      //fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 2.5,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Members'.toUpperCase(),
          style:
              GoogleFonts.aclonica(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF29648C),
      ),
      body: Scrollbar(
        thickness: 10,
        thumbVisibility: true,
        radius: const Radius.circular(10),
        child: Container(
          color: const Color.fromARGB(255, 24, 113, 172),
          child: SizedBox(
            height: double.infinity,
            child: FirebaseAnimatedList(
              query: dbRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map itemsin = snapshot.value as Map;
                itemsin['key'] = snapshot.key;

                return listUser(userInfo: itemsin);
              },
            ),
          ),
        ),
      ),
    );
  }
}
