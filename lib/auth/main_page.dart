import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:items_io/Auth/auth_page.dart';
import 'package:items_io/Pages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('MJQE Items IO')),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return const HomePage();
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something Went Wrong!'));
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
