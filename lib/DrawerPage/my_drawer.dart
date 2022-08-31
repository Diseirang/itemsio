// ignore_for_file: sort_child_properties_last
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:items_io/DrawerPage/about_developer.dart';
import '../Pages/member_report.dart';
import 'profile_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  State<MyDrawer> createState() => _DrawerState();
}

class _DrawerState extends State<MyDrawer> {
  final user = FirebaseAuth.instance.currentUser!;
  final padding = const EdgeInsets.symmetric(horizontal: 0);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color(0xFF29648C),
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Container(
              color: const Color.fromARGB(255, 0, 75, 85),
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 52,
                    backgroundImage: AssetImage('assets/images/logo.jpg'),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Text('Current User',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    user.email!,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  buildMenuItem(
                    text: 'Profile',
                    icon: Icons.person,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  buildMenuItem(
                    text: 'Members',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  buildMenuItem(
                    text: 'About Developer',
                    icon: Icons.warning,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 20,
                    thickness: 1,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout,
                    onClicked: () => selectedItem(context, 4),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: const TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    //Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).pop();
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ReportMember(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AboutPage(),
        ));
        break;
      case 4:
        FirebaseAuth.instance.signOut();
        break;
    }
  }
}
