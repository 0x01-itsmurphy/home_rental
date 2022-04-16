import 'package:flutter/material.dart';
import 'package:home_rental/controller/extention.dart';
import 'package:home_rental/controller/loading.dart';
import 'package:home_rental/view/homescreen/widgets/homepage_widget.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class UserDetailsHomeContainer extends StatefulWidget {
  final String picture;
  final String owner;
  final String address;
  final String rent;
  final String area;
  final VoidCallback onTap;
  const UserDetailsHomeContainer(
      {Key? key,
      required this.area,
      required this.picture,
      required this.owner,
      required this.address,
      required this.rent,
      required this.onTap})
      : super(key: key);

  @override
  State<UserDetailsHomeContainer> createState() =>
      _UserDetailsHomeContainerState();
}

class _UserDetailsHomeContainerState extends State<UserDetailsHomeContainer> {
  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.zero,
                height: 200 * MediaQuery.of(context).size.aspectRatio,
                width: 300 * MediaQuery.of(context).size.aspectRatio,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.picture,
                    fit: BoxFit.cover,
                    frameBuilder: (context, child, frame, _) {
                      if (frame == null) {
                        // fallback to placeholder
                        return const Center(child: Loading());
                      }
                      return child;
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.owner.toTitleCase(),
                      style: textStyle(size: 20, weight: FontWeight.w600),
                    ),
                    const CustomSizeBox(height: 10),
                    Text(
                      widget.address.toTitleCase(),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      style: textStyle(),
                    ),
                    const CustomSizeBox(height: 10),
                    Text(
                      widget.rent + ' Rs/month',
                      style: textStyle(),
                    ),
                    const CustomSizeBox(height: 10),
                    Text(
                      widget.area,
                      style: textStyle(),
                    ),
                  ],
                ),
              ),
              const CustomSizeBox(height: 10),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border_outlined),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextStyle textStyle(
          {double? size, FontWeight? weight, MaterialColor? color}) =>
      TextStyle(
        fontSize: size ?? 17,
        fontWeight: weight ?? FontWeight.normal,
        color: color ?? Colors.black,
      );
}
