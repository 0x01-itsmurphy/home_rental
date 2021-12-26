import 'package:flutter/material.dart';

class Facilities extends StatelessWidget {
  const Facilities({Key? key, required this.name, required this.asset})
      : super(key: key);
  final String name;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      // height: 100,
      width: 100,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        shadowColor: Colors.deepPurple[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
                asset,
                height: 2 * MediaQuery.of(context).size.height * 0.02,
                width: 2 * MediaQuery.of(context).size.height * 0.02,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.022,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ContactWidget extends StatelessWidget {
  final String text;

  final IconData? icon;

  const ContactWidget({Key? key, required this.text, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 25,
              color: Colors.deepPurple,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                text,
                style: textStyle(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  TextStyle textStyle({
    double? size,
    FontWeight? weight,
    MaterialColor? color,
  }) =>
      TextStyle(
        fontSize: size ?? 22,
        fontWeight: weight ?? FontWeight.w500,
        color: color ?? Colors.grey[700],
      );
}
