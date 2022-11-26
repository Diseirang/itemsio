import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:items_io/Widget/textField.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ItemsInPage extends StatefulWidget {
  const ItemsInPage({super.key});

  @override
  State<ItemsInPage> createState() => _ItemsInPageState();
}

class _ItemsInPageState extends State<ItemsInPage> {
  final takerNameController = TextEditingController();
  final takerIDController = TextEditingController();
  final positionController = TextEditingController();
  final departmentController = TextEditingController();
  final itemsNameController = TextEditingController();
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
    itemsNameController.dispose();
    quantityController.dispose();
    perposeController.dispose();
    dateController.dispose();
    campusController.dispose();
    super.dispose();
  }

  int i = 0;
  File? image;

  Future insertItemsINFirestore(
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
        .collection('itemsin')
        .doc(campus + DateTime.now().toString())
        .set(
      {
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
  }

  // Insert Data to Items OUT Realtime database
  void insertItemsINRealtime(
      String takerName,
      String takerID,
      String position,
      String department,
      String itemName,
      int quantity,
      String perpose,
      String date,
      String campus,
      String time) {
    //String? key = databaseReference  .child("ItemsIN")        .child(campus)        .child(takerID)    .push()        .key;
    databaseReference.child("itemsin").push().set(
      {
        //'Nº': key,
        'CurrentUser': user.email!,
        'StaffName': takerName,
        'ID': takerID,
        'Position': position,
        'Department': department,
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
    itemsNameController.clear();
    quantityController.clear();
    perposeController.clear();
    dateController.clear();
    campusController.clear();
  }

  void dialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: SizedBox(
            height: 120.0,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    takeImage();
                  },
                  child: const ListTile(
                    leading: Icon(Icons.camera),
                    title: Text('Camera'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    pickImage();
                  },
                  child: const ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Photo Gallery'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future takeImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTempory = File(image.path);
      setState(() => this.image = imageTempory);
    } on PlatformException {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Color.fromARGB(255, 41, 100, 140),
            title: Text('Fail!'),
            content: Text(
              'Fail to pick image!',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTempory = File(image.path);
      setState(() => this.image = imageTempory);
    } on PlatformException {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Color.fromARGB(255, 41, 100, 140),
            title: Text('Fail!'),
            content: Text(
              'Fail to pick image!',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }
  }

  final postRef = FirebaseDatabase.instance.ref().child('ItemsINPic');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  bool showSpinner = false;
  int date = DateTime.now().microsecondsSinceEpoch;
  Future<void> uplaodImage() async {
    try {
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('itemsIN $date');
      UploadTask uploadTask = ref.putFile(image!.absolute);
      await Future.value(uploadTask);

      var newURL = await ref.getDownloadURL();

      postRef.child('ItemsINImage').child(date.toString()).push().set({
        'pID': date.toString(),
        'pImage': newURL.toString(),
        'pTime': date.toString(),
      }).then((value) {
        toastMessage('Image Uploaded!');

        setState(() {
          showSpinner = false;
        });
      }).onError((error, stackTrace) {
        toastMessage(error.toString());
        showSpinner = false;
      });
    } catch (e) {
      setState(() {
        showSpinner = false;
      });
      toastMessage(e.toString());
    }
  }

  @override
  void initState() {
    dateController.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
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
            'Items IN'.toUpperCase(),
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
                        // InkWell(
                        //   onTap: () {
                        //     dialog(context);
                        //   },
                        //   child: SizedBox(
                        //     height: MediaQuery.of(context).size.height * .2,
                        //     width: double.infinity,
                        //     child: image != null
                        //         ? ClipRect(
                        //             child: Image.file(
                        //               image!.absolute,
                        //               width: 100,
                        //               height: 100,
                        //               fit: BoxFit.fitHeight,
                        //             ),
                        //           )
                        //         : Container(
                        //             decoration: BoxDecoration(
                        //               color: Colors.grey.shade200,
                        //               borderRadius: BorderRadius.circular(10),
                        //             ),
                        //             width: 100,
                        //             height: 100,
                        //             child: const Icon(
                        //               Icons.camera_alt,
                        //               color: Color.fromARGB(255, 41, 100, 140),
                        //             ),
                        //           ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
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
                                    keyboardType: TextInputType.text,
                                    controller: takerNameController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Staff Name',
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 41, 100, 140),
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
                            borderRadius: BorderRadius.circular(5),
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
                              InputField(
                                controller: takerIDController,
                                keyboardType: TextInputType.number,
                                myhintText: 'ID',
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
                            borderRadius: BorderRadius.circular(5),
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
                              InputField(
                                controller: positionController,
                                keyboardType: TextInputType.text,
                                myhintText: 'Position',
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
                            borderRadius: BorderRadius.circular(5),
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
                                    keyboardType: TextInputType.text,
                                    controller: departmentController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Department',
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 41, 100, 140),
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
                            borderRadius: BorderRadius.circular(5),
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
                                    keyboardType: TextInputType.text,
                                    controller: itemsNameController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Item Name',
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 41, 100, 140),
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
                            borderRadius: BorderRadius.circular(5),
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
                                    keyboardType: TextInputType.number,
                                    controller: quantityController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Quantity',
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 41, 100, 140),
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
                            borderRadius: BorderRadius.circular(5),
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
                                    keyboardType: TextInputType.text,
                                    controller: perposeController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Purpose',
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 41, 100, 140),
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
                            borderRadius: BorderRadius.circular(5),
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
                                    keyboardType: TextInputType.none,
                                    controller: dateController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Date',
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 41, 100, 140),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.calendar_month,
                                        color:
                                            Color.fromARGB(255, 41, 100, 140),
                                      ),
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
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
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const AlertDialog(
                                              backgroundColor: Color.fromARGB(
                                                  255, 41, 100, 140),
                                              title: Text(
                                                'Invalided Date!',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              content: Text(
                                                'Date is not selected',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            );
                                          },
                                        );
                                      }
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
                            borderRadius: BorderRadius.circular(5),
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
                                        color:
                                            Color.fromARGB(255, 41, 100, 140),
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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: const [
                        //     Text(
                        //       'Choose image: ',
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.white),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Container(
                        //   decoration: const BoxDecoration(
                        //     color: Colors.white,
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Color.fromARGB(255, 45, 231, 255),
                        //         blurRadius: 20.0,
                        //         offset: Offset(0, 10),
                        //       ),
                        //     ],
                        //   ),
                        //   child: GestureDetector(
                        //     onTap: pickImage,
                        //     child: Column(
                        //       children: [
                        //         image != null
                        //             ? Image.file(image!,
                        //                 width: double.infinity,
                        //                 height: 160,
                        //                 fit: BoxFit.cover)
                        //             : const Image(
                        //                 height: 160,
                        //                 width: double.infinity,
                        //                 fit: BoxFit.cover,
                        //                 image: AssetImage(
                        //                     'assets/images/defaultImage.png'))
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
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
                              border: Border.all(color: Colors.white, width: 2),
                              color: const Color(0xFF29648C),
                              borderRadius: BorderRadius.circular(50),
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
                                itemsNameController.text.isNotEmpty &&
                                quantityController.text.isNotEmpty &&
                                perposeController.text.isNotEmpty &&
                                dateController.text.isNotEmpty &&
                                campusController.text.isNotEmpty) {
                              try {
                                // Insert Items OUT to Firestore database
                                insertItemsINFirestore(
                                    takerNameController.text.trim(),
                                    takerIDController.text.trim(),
                                    positionController.text.trim(),
                                    departmentController.text.trim(),
                                    itemsNameController.text.trim(),
                                    int.parse(quantityController.text.trim()),
                                    perposeController.text.trim(),
                                    dateController.text.trim(),
                                    campusController.text.trim(),
                                    DateTime.now().toString());

                                // Insert Items OUT to Realtime database
                                insertItemsINRealtime(
                                    takerNameController.text.trim(),
                                    takerIDController.text.trim(),
                                    positionController.text.trim(),
                                    departmentController.text.trim(),
                                    itemsNameController.text.trim(),
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
                                      backgroundColor: const Color.fromARGB(
                                          255, 41, 100, 140),
                                      title: const Text(
                                        'Data not filled!',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      content: Text(
                                        e.message.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
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
      ),
    );
  }
}

void toastMessage(String message) {
  Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0);
}
