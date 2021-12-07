import 'package:flutter/material.dart';
import 'package:home_rental/view/register/signin.dart';
import 'package:home_rental/view/register/signup.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggle: toggleView);
    } else {
      return SignUp(
        toggle: toggleView,
      );
    }
  }
}
