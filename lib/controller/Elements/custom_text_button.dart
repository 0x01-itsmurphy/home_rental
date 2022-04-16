import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  final String? text;
  final bool? isLoading;
  final Color? color;
  final Color? loadingColor;
  final VoidCallback? onTap;
  const CustomTextButton({
    Key? key,
    required this.isLoading,
    this.color,
    this.loadingColor,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  _CustomTextButtonState createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      height: 50,
      width: widget.isLoading == true ? 60 : screenWidth,
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: widget.isLoading == true
            ? BorderRadius.circular(8)
            : BorderRadius.circular(10),
        color: widget.color ?? Colors.deepPurple,
      ),
      duration: const Duration(microseconds: 200),
      child: widget.isLoading!
          ? Center(
              child: CircularProgressIndicator(
                color: widget.loadingColor ?? Colors.white,
              ),
            )
          : Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                child: Center(
                  child: Text(
                    widget.text!,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
    );
  }
}
