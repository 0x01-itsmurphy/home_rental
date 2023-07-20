// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_rental/models/allposts_model.dart';
import 'package:home_rental/view/details_page/details_page.dart';
import 'package:home_rental/view/drawer/side_drawer.dart';
import 'package:home_rental/view/homescreen/widgets/custom_floating_action.dart';
import 'package:home_rental/view/homescreen/widgets/custom_sliver_appbar.dart';
import 'package:home_rental/view/homescreen/widgets/user_details_home_container.dart';
import 'package:home_rental/view/register/signin.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String? message;
List<UserDetailsModel>? users;

bool loading = true;

class _HomeScreenState extends State<HomeScreen> {
  Future fetchAllPosts() async {
    final response =
        await http.get(Uri.parse('https://$baseUrl/api/getallposts'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      message = jsonResponse['message'].toString();
      var list = jsonResponse['users'] as List;

      users = list.map((user) => UserDetailsModel.fromJson(user)).toList();

      print(message);
      print(users!.length);
      print(users![1].address);
    } else {
      throw Exception(
          message = 'Request failed with status: ${response.statusCode}');
    }

    // setState(() {
    //   loading = false;
    // });
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            drawer: const SideDrawer(),
            floatingActionButton: const CustomFloatingActionButton(),
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  const CustomSliverAppBar(),
                ];
              },
              body: RefreshIndicator(
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 2));
                  setState(() {
                    fetchAllPosts();
                  });
                },
                child: FutureBuilder(
                  future: fetchAllPosts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: users == null ? 0 : users!.length,
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemBuilder: (context, index) {
                          int reverseIndex = users!.length - 1 - index;
                          return UserDetailsHomeContainer(
                            picture: users![reverseIndex].picture!,
                            owner: users![reverseIndex].owner!,
                            address: users![reverseIndex].address!,
                            area: users![reverseIndex].size!,
                            rent: users![reverseIndex].rent!,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DetailsPage(),
                                  settings: RouteSettings(
                                    arguments: users![reverseIndex],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(
                      child:
                          Lottie.asset('assets/lottie/loading-paperplane.json'),
                    );
                  },
                ),
              ),
            )),
      ),
    );
  }
}
