// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:home_rental/controller/extention.dart';
import 'package:home_rental/controller/loading.dart';
import 'package:home_rental/view/details_page/details_page.dart';
import 'package:home_rental/view/homescreen/widgets/custom_floating_action.dart';
import 'package:home_rental/view/homescreen/widgets/custom_sliver_appbar.dart';
import 'package:home_rental/view/drawer/side_drawer.dart';
import 'package:home_rental/view/homescreen/widgets/homepage_widget.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:home_rental/view/homescreen/widgets/user_details_home_container.dart';
import 'package:http/http.dart' as http;
import 'package:home_rental/models/allposts_model.dart';
import 'package:provider/provider.dart';

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
    final response = await http
        .get(Uri.parse('https://homeforrent.herokuapp.com/api/getallposts'));

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
    return Scaffold(
        drawer: const SideDrawer(),
        floatingActionButton: const CustomFloatingActionButton(),
        body: SafeArea(
          child: NestedScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                const CustomSliverAppBar(),
              ];
            },
            body: RefreshIndicator(
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
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ));
  }
}
