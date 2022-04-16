import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_rental/controller/authentication/toggle_page_switch.dart';
import 'package:home_rental/controller/provider/google_signin_provider.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.deepPurple[300]),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    child: ClipOval(
                      child: Image.network(
                        currentUser.photoURL!,
                        width: 150,
                      ),
                    ),
                  ),
                  accountName: Text(
                    currentUser.displayName!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text(currentUser.email!),
                ),
                ListTile(
                  title: const Text(
                    'About',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.account_box_outlined),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text(
                    'Support',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.support),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text(
                    'Settings',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    'Close',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.close),
                  onTap: () => Navigator.of(context).pop(),
                ),
                const Divider(),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                provider.googleSignOut().then((value) =>
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AuthPageToggleSwitch()),
                        (route) => false));
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
