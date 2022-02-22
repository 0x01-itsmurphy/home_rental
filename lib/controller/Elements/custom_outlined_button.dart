import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final ImageProvider image;
  const CustomOutlinedButton(
      {Key? key, required this.onPressed, required this.image})
      : super(key: key);

  @override
  _CustomOutlinedButtonState createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Image(
          image: widget.image,
          height: 30,
          width: 60,
        ),
      ),
    );
  }
}
