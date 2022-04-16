// ignore_for_file: avoid_print
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_rental/controller/provider/google_signin_provider.dart';
import 'package:home_rental/view/homescreen/homescreen.dart';
import 'package:home_rental/view/introduction_page/introduction_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

String? token;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const IntroductionPage();
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
        page = const IntroductionPage();
      });
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MaterialColor myColor = const MaterialColor(0xFF6C63FF, <int, Color>{
    //   50: Color.fromRGBO(4, 131, 184, .1),
    //   100: Color.fromRGBO(4, 131, 184, .2),
    //   200: Color.fromRGBO(4, 131, 184, .3),
    //   300: Color.fromRGBO(4, 131, 184, .4),
    //   400: Color.fromRGBO(4, 131, 184, .5),
    //   500: Color.fromRGBO(4, 131, 184, .6),
    //   600: Color.fromRGBO(4, 131, 184, .7),
    //   700: Color.fromRGBO(4, 131, 184, .8),
    //   800: Color.fromRGBO(4, 131, 184, .9),
    //   900: Color.fromRGBO(4, 131, 184, 1),
    // });

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        // ChangeNotifierProvider(create: (_) => NetworkApiProvider()),
      ],
      child: MaterialApp(
        builder: EasyLoading.init(),
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
      ),
    );
  }
}
