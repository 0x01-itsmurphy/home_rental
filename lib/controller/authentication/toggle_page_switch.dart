import 'package:flutter/material.dart';
import 'package:home_rental/view/Screens/register/signin.dart';
import 'package:home_rental/view/Screens/register/signup.dart';

class AuthPageToggleSwitch extends StatefulWidget {
  const AuthPageToggleSwitch({Key? key}) : super(key: key);

  @override
  _AuthPageToggleSwitchState createState() => _AuthPageToggleSwitchState();
}

class _AuthPageToggleSwitchState extends State<AuthPageToggleSwitch> {
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
