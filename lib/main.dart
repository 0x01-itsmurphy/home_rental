import 'package:flutter/material.dart';
import 'package:home_rental/view/homescreen/homescreen.dart';
import 'package:home_rental/view/login_signup/signin.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Rental',
      initialRoute: '/',
      routes: {
        '/': (context) => const SignIn(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
