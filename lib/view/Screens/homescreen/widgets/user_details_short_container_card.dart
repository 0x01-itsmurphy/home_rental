import 'package:flutter/material.dart';
import 'package:home_rental/controller/extention.dart';
import 'package:home_rental/controller/loading.dart';
import 'package:home_rental/view/Screens/homescreen/widgets/homepage_widget.dart';

class UserDetailsShortContainerCard extends StatefulWidget {
  // final Widget? networkImageChild;
  final String? userName;
  final String? address;
  final String? rent;
  final String? area;
  final String? networkImage;

  const UserDetailsShortContainerCard({
    Key? key,
    // required this.networkImageChild,
    required this.userName,
    required this.address,
    required this.rent,
    required this.area,
    this.networkImage,
  }) : super(key: key);

  @override
  State<UserDetailsShortContainerCard> createState() =>
      _UserDetailsShortContainerCardState();
}

class _UserDetailsShortContainerCardState
    extends State<UserDetailsShortContainerCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                  widget.networkImage!,
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
                    widget.userName!.toTitleCase(),
                    style: textStyle(size: 20, weight: FontWeight.w600),
                  ),
                  const CustomSizeBox(height: 10),
                  Text(
                    widget.address!.toTitleCase(),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: textStyle(),
                  ),
                  const CustomSizeBox(height: 10),
                  Text(
                    widget.rent! + ' Rs/month',
                    style: textStyle(),
                  ),
                  const CustomSizeBox(height: 10),
                  Text(
                    widget.area! + ' sq. ft.',
                    style: textStyle(),
                  ),
                ],
              ),
            ),
            const CustomSizeBox(height: 10),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border_outlined))
          ],
        ),
      ),
    );
  }

  TextStyle textStyle({
    double? size,
    FontWeight? weight,
    MaterialColor? color,
  }) =>
      TextStyle(
        fontSize: size ?? 18,
        fontWeight: weight ?? FontWeight.normal,
        color: color ?? Colors.black,
      );
}
