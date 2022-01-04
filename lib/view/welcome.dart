import 'package:flutter/material.dart';
import 'package:home_rental/controller/authentication.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          color: Colors.amberAccent,
          child: const Text("Welcome"),
          onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Authentication())),
        ),
      ),
    );
  }
}
