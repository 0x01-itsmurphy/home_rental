// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_rental/controller/API/api_endpoints.dart';
import 'package:home_rental/models/allposts_model.dart';
import 'package:http/http.dart' as http;

class HomeScreenAllPostsProvider extends ChangeNotifier {
  // String? message;
  // List<UserDetailsModel>? users;

  // UserDetailsModel? allUserPosts = UserDetailsModel();

  // Future fetchAllPosts() async {
  //   final response = await http
  //       .get(Uri.parse('https://homeforrent.herokuapp.com/api/getallposts'));

  //   if (response.statusCode == 200) {
  //     var jsonResponse = json.decode(response.body);
  //     message = jsonResponse['message'].toString();
  //     var list = jsonResponse['users'] as List;

  //     users = list.map((user) => UserDetailsModel.fromJson(user)).toList();

  //     print(message);
  //     print(users);
  //     print(users![1].address);
  //   } else {
  //     throw Exception(
  //       message = 'Request failed with status: ${response.statusCode}',
  //     );
  //   }

  //   // setState(() {
  //   //   loading = false;
  //   // });
  //   notifyListeners();
  //   return users;
  // }

  UserDetailsModel? allUserPosts = UserDetailsModel();

  bool? isLoading = true;

  Future<void> getAllUserPostsDetails(
      BuildContext? context, bool loading) async {
    isLoading = true;
    await ApiEndpoints()
        .getAllUsersPosts(context: context, showLoading: loading)
        .then((value) {
      allUserPosts = UserDetailsModel.fromJson(value.users);
      isLoading = false;
      notifyListeners();
    });
  }
}
