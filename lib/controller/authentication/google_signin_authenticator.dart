import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_rental/controller/authentication/toggle_page_switch.dart';
import 'package:home_rental/view/homescreen/homescreen.dart';

class GoogleSignInAuthenticator extends StatelessWidget {
  const GoogleSignInAuthenticator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const HomeScreen();
        } else if (snapshot.hasError) {
          return const Center(child: Text('Someting went wrong!'));
        } else {
          return const AuthPageToggleSwitch();
        }
      },
    );
  }
}
