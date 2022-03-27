import 'package:flutter/material.dart';

class CustomSocialMediaButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final ImageProvider image;
  const CustomSocialMediaButton(
      {Key? key, required this.onPressed, required this.image})
      : super(key: key);

  @override
  _CustomSocialMediaButtonState createState() => _CustomSocialMediaButtonState();
}

class _CustomSocialMediaButtonState extends State<CustomSocialMediaButton> {
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
