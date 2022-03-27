// import 'package:flutter/material.dart';
// import 'package:home_rental/controller/API/api_endpoints.dart';
// import 'package:home_rental/controller/provider/homescreen_allposts_provider.dart';
// import 'package:home_rental/models/allposts_model.dart';
// import 'package:home_rental/view/Screens/homescreen/homescreen.dart';
// import 'package:home_rental/view/Screens/homescreen/widgets/user_details_short_container_card.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool? isLoading = true;
//   List<UserDetailsModel>? allUserPosts;
//   @override
//   initState() {
//     getAllUserPostsDetails(context, true);
//     super.initState();
//   }

//   Future<void> getAllUserPostsDetails(
//       BuildContext? context, bool loading) async {
//     isLoading = true;
//     await ApiEndpoints()
//         .getAllUsersPosts(context: context, showLoading: loading)
//         .then((value) {
//       allUserPosts =
//           UserDetailsModel.fromJson(value.users) as List<UserDetailsModel>?;
//       // List<UserDetailsModel> userData =
//       //     List<UserDetailsModel>.from(value.users).toList();
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var homeUserDetails =
//         Provider.of<HomeScreenAllPostsProvider>(context, listen: false);
//     return Scaffold(
//       body: SafeArea(
//         child: ListView.builder(
//           // itemCount: ,
//           itemBuilder: (context, index) {
//             return UserDetailsShortContainerCard(
//               // networkImageChild: Image(
//               //   image: NetworkImage(homeUserDetails.allUserPosts!.picture.toString()),
//               // ),
//               userName: homeUserDetails[index],
//               address: '',
//               rent: '',
//               area: '',
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
