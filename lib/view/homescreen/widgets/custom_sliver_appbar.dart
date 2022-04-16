import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const Icon(
          Icons.menu_open_outlined,
          size: 30,
          color: Colors.grey,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            size: 30,
            color: Colors.grey,
          ),
          onPressed: () {},
        ),
      ],
      expandedHeight: 200.0,
      floating: true,
      pinned: true,
      title: Padding(
        padding: const EdgeInsets.all(0),
        child: CupertinoTextField(
          keyboardType: TextInputType.text,
          placeholder: 'Search',
          placeholderStyle: const TextStyle(
            fontSize: 15.0,
          ),
          prefix: const Padding(
            padding: EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[300],
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Bounceable(
          onTap: () {},
          child: Image.asset(
            "assets/images/undraw_rent_house.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
