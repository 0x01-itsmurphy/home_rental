import 'package:flutter/material.dart';

class HeadingWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final ImageProvider image;

  const HeadingWidget(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        Text(
          subTitle,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Image(
            width: width / 1.7,
            // image: const AssetImage('assets/images/blue-house.gif'),
            image: image,
          ),
        ),
      ],
    );
  }
}
