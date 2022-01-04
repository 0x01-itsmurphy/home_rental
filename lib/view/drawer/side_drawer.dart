import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple[300]),
            accountName: const Text(
              'User Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text('test@test.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 80,
              child: ClipOval(
                child: Image.network(
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                  width: 150,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'About',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.account_box_outlined),
            onTap: () {
              // Navigator.of(context).pop();
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (BuildContext context) {},
              // ));
            },
          ),
          ListTile(
            title: const Text(
              'Support',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.support),
            onTap: () {
              Navigator.of(context).pop();
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (BuildContext context) => Support(),
              // ));
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
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (BuildContext context) => Settings(),
              // ));
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
          TextButton(
            onPressed: () {},
            child: const Text(
              'Sign Out',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
