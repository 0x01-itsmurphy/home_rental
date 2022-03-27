import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  final Widget child;
  const CustomTextButton({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _CustomTextButtonState createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepPurple,
      ),
      child: widget.child,
    );
  }
}
