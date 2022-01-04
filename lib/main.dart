// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:home_rental/view/homescreen/homescreen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_rental/view/welcome.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  runApp(const MyApp());
}

String? token;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const WelcomePage();
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  void checkAuth() async {
    token = await storage.read(key: "token");

    print("Starting token check---> $token");
    if (token != null) {
      setState(() {
        page = const HomeScreen();
      });
    } else {
      setState(() {
        page = const WelcomePage();
      });
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Home Rental',
      // initialRoute: '/',
      // routes: {
      //   '/home': (context) => page,
      // },
      home: page,
    );
  }
}
