// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_rental/controller/extention.dart';

import 'package:http/http.dart' as http;
import 'package:home_rental/models/allposts_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String? message;
List? users;

class _HomeScreenState extends State<HomeScreen> {
  Future fetchAllPosts() async {
    final response = await http
        .get(Uri.parse('https://homeforrent.herokuapp.com/api/getallposts'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      message = jsonResponse['message'].toString();
      // users = jsonResponse['users'];

      users = jsonResponse['users'].map((user) => User.fromJson(user)).toList();

      // isAvailable = users![1]['available'];

      print(message);
      print(users!.length);
      print(users![1].address);
      print(users![1].username);
    } else {
      message = 'Request failed with status: ${response.statusCode}';
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () {
            fetchAllPosts();
          },
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // Another Widget can be added
              SliverPersistentHeader(
                delegate: MySliverAppBar(expandedHeight: 200),
                pinned: true,
              )
            ];
          },
          body: Container(
            color: Colors.deepPurple[100],
            child: FutureBuilder(
              future: fetchAllPosts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          //TODO Navigation to Details Page

                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              users![index].picture,
                                              fit: BoxFit.cover,
                                              height: 250 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .aspectRatio,
                                              width: 350 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .aspectRatio,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${users![index].owner}'
                                                .toTitleCase(),
                                            style: textStyle(
                                                size: 22,
                                                weight: FontWeight.w600),
                                          ),
                                          sizedBox(10),
                                          Text(
                                            '${users![index].address}'
                                                .toTitleCase(),
                                            style: textStyle(),
                                          ),
                                          sizedBox(10),
                                          Text(
                                            '${users![index].rent} Rs/month',
                                            style: textStyle(),
                                          ),
                                          sizedBox(10),
                                          Text(
                                            '${users![index].size} sq. ft.',
                                            style: textStyle(),
                                          ),
                                        ],
                                      ),
                                      sizedBox(10),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.favorite_border_outlined))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: users == null ? 0 : users!.length);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ));
  }

  SizedBox sizedBox(double height) {
    return SizedBox(
      height: height * MediaQuery.of(context).size.aspectRatio,
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

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Image.network(
          "https://source.unsplash.com/240x240/?house,home,rent",
          fit: BoxFit.cover,
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: const Text(
              "Room's For Rent",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 1.2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 13,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                height: MediaQuery.of(context).size.width / 8,
                width: MediaQuery.of(context).size.width / 1.2,
                child: TextFormField(
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 5.0),
                    ),
                    hintText: "Search",
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
