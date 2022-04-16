import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_rental/view/homescreen/homescreen.dart';
import 'package:lottie/lottie.dart';

class SuccessfullMessage extends StatefulWidget {
  const SuccessfullMessage({Key? key}) : super(key: key);

  @override
  State<SuccessfullMessage> createState() => _SuccessfullMessageState();
}

class _SuccessfullMessageState extends State<SuccessfullMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/success_message.json'),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Successfull 🏡',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: const [
                    Text(
                      'Congratulations!🎉🎉,',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your post has been uploaded!!!',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  width: 200,
                  height: 50,
                  child: const Text("Continue"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
