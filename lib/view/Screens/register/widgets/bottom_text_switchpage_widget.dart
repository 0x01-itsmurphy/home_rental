import 'package:flutter/material.dart';

class BottomTextSwitch extends StatelessWidget {
  final VoidCallback onPressed;
  final String firstText;
  final String secondText;
  const BottomTextSwitch(
      {Key? key,
      required this.onPressed,
      required this.firstText,
      required this.secondText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            secondText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ),
      ],
    );
  }
}
