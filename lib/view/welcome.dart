import 'package:flutter/material.dart';
import 'package:home_rental/controller/authentication.dart';
import 'package:introduction_screen/introduction_screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

Widget _buildImage(String assetName, [double width = 300]) {
  return Image.asset('assets/welcome/$assetName', width: width);
}

class _WelcomePageState extends State<WelcomePage> {
  final pageKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 18.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IntroductionScreen(
            key: pageKey,
            globalBackgroundColor: Colors.white,
            pages: [
              PageViewModel(
                title: 'Welcome',
                body:
                    "New in city?\n Want to find a place to stay? \n Then, SignUp and Search.",
                image: _buildImage('search.png'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: 'Find Room',
                body: "Find your suitable room\n from various locations.",
                image: _buildImage('find.png'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: 'Contact',
                body:
                    "Done searching your room! \n Easily contact to Roomowner \n or visit the location.",
                image: _buildImage('contact.png'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: 'Upload',
                body:
                    "You have empty room! \n And want to rent it, \n Then, Just upload your details.",
                image: _buildImage('post_details.png'),
                decoration: pageDecoration,
              )
            ],
            onDone: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Authentication(),
              ),
            ),
            showSkipButton: true,
            skipFlex: 0,
            nextFlex: 0,
            skip: const Text(
              'Skip',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onSkip: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Authentication(),
              ),
            ),
            next: const Icon(Icons.arrow_forward),
            done: const Text('Done',
                style: TextStyle(fontWeight: FontWeight.w600)),
            curve: Curves.fastLinearToSlowEaseIn,
            controlsMargin: const EdgeInsets.all(16),
            dotsDecorator: const DotsDecorator(
              size: Size(5.0, 10.0),
              // color: Colors.deepPurple,
              activeSize: Size(20.0, 5.0),
              activeColor: Colors.deepPurple,
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
          ),
        ),
      ),
      // Center(
      //   child: MaterialButton(
      //     color: Colors.amberAccent,
      //     child: const Text("Welcome"),
      //     onPressed: () => Navigator.pushReplacement(context,
      //         MaterialPageRoute(builder: (context) => const Authentication())),
      //   ),
      // ),
    );
  }
}
