import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:items_io/pages/about_system.dart';
import '../InOutPage/items_in_page.dart';
import '../InOutPage/items_out_page.dart';
import '../InOutReport/items_in_report.dart';
import '../InOutReport/items_out_report.dart';
import '../drawer_page/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  double xOffSet = 0;
  double yOffSet = 0;
  double scaleFactor = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: MyDrawer(),
      ),
      backgroundColor: const Color.fromARGB(255, 41, 100, 140),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 41, 100, 140),
        title: Text(
          'MJQE IT Items IO'.toUpperCase(),
          style:
              GoogleFonts.aclonica(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: AnimatedContainer(
          transform: Matrix4.translationValues(xOffSet, yOffSet, 0)
            ..scale(scaleFactor),
          duration: const Duration(microseconds: 250),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text Items IO
                    Text(
                      'Items IO',
                      style: GoogleFonts.rubikMoonrocks(
                          fontSize: 28, color: Colors.white),
                    ),
                    // Logo
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF29648C),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 45, 231, 255),
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          )
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: GestureDetector(
                        onDoubleTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const AboutSystem();
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/images/logo.jpg'),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  //color: Color.fromARGB(255, 45, 231, 255),
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: const [
                              //const Text(
                              //  'You\'ve signed in as ',
                              //  style: TextStyle(
                              //      color: Colors.white, fontSize: 24),
                              //),
                              SizedBox(
                                height: 5,
                              ),
                              //Text(
                              //  user.email!,
                              ////  style: const TextStyle(
                              //     fontWeight: FontWeight.bold,
                              ////     color: Colors.white,
                              //     fontSize: 16),
                              /// ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      //height: 50,
                      decoration: BoxDecoration(
                        //color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
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
                          const SizedBox(
                            height: 10,
                          ),
                          ///////////////////////////

                          const SizedBox(
                            height: 10,
                          ),

                          Container(
                            height: 100,
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const ItemsInPage();
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 4),
                                  color: const Color(0xFF29648C),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.arrow_downward_outlined,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Items In'.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const ItemsOutPage();
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 4),
                                  color: const Color(0xFF29648C),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.arrow_upward_outlined,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Items Out'.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //Items IN report
                          Container(
                            height: 100,
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const ItemsInReport();
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 4),
                                  color: const Color(0xFF29648C),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.notes,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Items In Report'.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //Items Out Report
                          Container(
                            height: 100,
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const ItemsOutReport();
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 4),
                                  color: const Color(0xFF29648C),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.notes,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Items Out Report'.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //Container(
                          //  padding: const EdgeInsets.all(5),
                          //  child: GestureDetector(
                          //    onTap: () {
                          //     FirebaseAuth.instance.signOut();
                          //   },
                          //   child: Container(
                          //    //height: 50,
                          //    decoration: BoxDecoration(
                          ////       border: Border.all(
                          //           color: Colors.white, width: 4),
                          //       color: const Color(0xFF29648C),
                          //       borderRadius: BorderRadius.circular(12),
                          //     ),
                          //    child: Padding(
                          //      padding: const EdgeInsets.all(15),
                          //       child: Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.center,
                          //        children: [
                          //           const Icon(
                          //            Icons.logout,
                          //            size: 25,
                          //            color: Colors.white,
                          //          ),
                          //          const SizedBox(
                          //            width: 10,
                          //          ),
                          //          Text(
                          //           'Sign Out',
                          //           style: GoogleFonts.pacifico(
                          //                 fontSize: 20,
                          //                 color: Colors.white,
                          //                 fontWeight: FontWeight.bold),
                          //           ),
                          //         ],
                          //       ),
                          //    ),
                          //  ),
                          //),
                          //),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
