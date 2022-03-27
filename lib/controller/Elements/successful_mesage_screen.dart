import 'package:flutter/material.dart';
import 'package:home_rental/view/homescreen/homescreen.dart';

class SuccessfullMessage extends StatefulWidget {
  const SuccessfullMessage({Key? key}) : super(key: key);

  @override
  State<SuccessfullMessage> createState() => _SuccessfullMessageState();
}

class _SuccessfullMessageState extends State<SuccessfullMessage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                width: 150,
                image: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/512/845/845646.png'),
              ),
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
                child: const Text(
                  'Congratulations!🎉🎉, \nYour post has been uploaded!!!',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
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
