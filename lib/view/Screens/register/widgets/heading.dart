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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // 'Welcome,',
          title,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        Text(
          // 'Sign in to continue!',
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
            width: 2 * MediaQuery.of(context).size.width * 0.3,
            // image: const AssetImage('assets/images/blue-house.gif'),
            image: image,
          ),
        ),
      ],
    );
  }
}
