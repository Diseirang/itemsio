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
  Query dbRef = FirebaseDatabase.instance.ref().child('users');
  //.orderByChild('Date')
  //.startAt(DateTime.now());
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('users');
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name : ' + userInfo['userName'],
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  'ID : ' + userInfo["idCard"].toString(),
                  style: const TextStyle(
                      //fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textDirection: TextDirection.ltr,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Position : ' + userInfo["position"].toString(),
                  style: const TextStyle(
                      //fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textDirection: TextDirection.ltr,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Email : ' + userInfo["email"],
                  style: const TextStyle(
                      //fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textDirection: TextDirection.ltr,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 5,
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
          ],
        ),
      ),
    );
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
        title: Text(
          'Members'.toUpperCase(),
          style:
              GoogleFonts.aclonica(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF29648C),
      ),
      body: Scrollbar(
        thickness: 5,
        radius: const Radius.circular(10),
        thumbVisibility: true,
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
