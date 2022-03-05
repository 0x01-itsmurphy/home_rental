import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:home_rental/view/post_data/user_data_post.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      child: const Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      activeBackgroundColor: Colors.black,
      overlayOpacity: 0.4,
      overlayColor: Colors.black12,
      spaceBetweenChildren: 8,
      children: <SpeedDialChild>[
        SpeedDialChild(
          child: const Icon(Icons.post_add),
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurple,
          label: 'Post',
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PostData()));
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.settings),
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurple,
          label: 'Settings',
          onTap: () {},
        ),
      ],
    );
  }
}
