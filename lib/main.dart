import 'package:flutter/material.dart';
import 'package:home_rental/controller/authentication.dart';
import 'package:home_rental/view/homescreen/homescreen.dart';

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
        '/': (context) => const Authentication(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
