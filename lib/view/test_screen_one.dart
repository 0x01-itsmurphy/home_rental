// // ignore_for_file: avoid_print

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:home_rental/models/json_model.dart';
// import 'package:home_rental/pages/details_page.dart';

// class TextOne extends StatefulWidget {
//   const TextOne({Key? key}) : super(key: key);

//   @override
//   _TextOneState createState() => _TextOneState();
// }

// class _TextOneState extends State<TextOne> {
//   Future<List<FetchJson>> fetchJson() async {
//     final response = await rootBundle.loadString('assets/rentalapp.json');

//     List<dynamic> jsonModel = jsonDecode(response);
//     List<FetchJson> jsonData =
//         jsonModel.map((i) => FetchJson.fromJson(i)).toList();
//     print(jsonData.length);
//     print(jsonData[1].id);
//     print(jsonData[1].rent);
//     // final jsonModel1 = jsonModel.toJson();
//     // print(jsonModel.toString());
//     return jsonData;
//   }

//   @override
//   void initState() {
//     fetchJson();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Rental'),
//       ),
//       body: FutureBuilder<List<FetchJson>>(
//         future: fetchJson(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             var data = snapshot.data;
//             return Column(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.3,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage(
//                         'https://source.unsplash.com/480x480/?home,house,office',
//                       ),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: data!.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const DetailsPage(
//                                   fetchJson: [],
//                                 ),
//                                 settings: RouteSettings(
//                                   arguments: data[index],
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(20.0),
//                               border: Border.all(color: Colors.grey),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10.0, vertical: 10.0),
//                               child: Row(
//                                 children: <Widget>[
//                                   Stack(
//                                     clipBehavior: Clip.none,
//                                     children: <Widget>[
//                                       ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(15.0),
//                                         child: Image(
//                                           image: NetworkImage(
//                                               data[index].picture.toString()),
//                                           fit: BoxFit.cover,
//                                           height: 240 *
//                                               MediaQuery.of(context)
//                                                   .size
//                                                   .aspectRatio,
//                                           width: 240 *
//                                               MediaQuery.of(context)
//                                                   .size
//                                                   .aspectRatio,
//                                         ),
//                                       ),
//                                       Positioned(
//                                         left: 4.0,
//                                         bottom: 5.0,
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             color: Colors.red,
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0),
//                                           ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(4.0),
//                                             child: Row(
//                                               children: <Widget>[
//                                                 Icon(
//                                                   Icons.favorite,
//                                                   color: Colors.white,
//                                                   size: 35 *
//                                                       MediaQuery.of(context)
//                                                           .size
//                                                           .aspectRatio,
//                                                 ),
//                                                 SizedBox(
//                                                   width: 5 *
//                                                       MediaQuery.of(context)
//                                                           .size
//                                                           .aspectRatio,
//                                                 ),
//                                                 Text(
//                                                   data[index].likes.toString(),
//                                                   style: const TextStyle(
//                                                       color: Colors.white,
//                                                       fontSize: 14.4),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     width: 25 *
//                                         MediaQuery.of(context).size.aspectRatio,
//                                   ),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       Text(
//                                         data[index].owner.toString(),
//                                         style: const TextStyle(
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 22.2),
//                                       ),
//                                       SizedBox(
//                                         height: 1.3 *
//                                             MediaQuery.of(context)
//                                                 .size
//                                                 .aspectRatio,
//                                       ),
//                                       Text(
//                                         "Price: ${data[index].rent.toString()}",
//                                         style: const TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 18.8,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 10 *
//                                             MediaQuery.of(context)
//                                                 .size
//                                                 .aspectRatio,
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Text(
//                                             "${data[index].size.toString()} sq.ft",
//                                             style: const TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 20),
//                                           ),
//                                           SizedBox(
//                                             width: 3 *
//                                                 MediaQuery.of(context)
//                                                     .size
//                                                     .aspectRatio,
//                                           ),
//                                         ],
//                                       ),
//                                       const Text(
//                                         "2BHK",
//                                         style: TextStyle(
//                                             color: Colors.black, fontSize: 20),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             );

//             // ListView.builder(
//             //   itemCount: data!.length,
//             //   itemBuilder: (context, index) {
//             //     return ListTile(
//             //       title: Text(data[index].id.toString()),
//             //       subtitle: Text(data[index].rent.toString()),
//             //       trailing: const Icon(Icons.arrow_forward_ios),
//             //       onTap: () {
//             //         Navigator.push(
//             //           context,
//             //           MaterialPageRoute(
//             //             builder: (context) => const
//             //             DetailsPage(
//             //               fetchJson: [],
//             //             ),
//             //             settings: RouteSettings(
//             //               arguments: data[index],
//             //             ),
//             //           ),
//             //         );
//             //         // Navigator.push(context,
//             //         //     MaterialPageRoute(builder: (context) => RentTwo()));
//             //       },
//             //     );
//             //   },
//             // );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//         // builder: (context, snapshot) {
//         //   if (snapshot.hasData ) {
//         //   var data = snapshot.data;
//         //     return ListView.builder(
//         //       itemCount: data!.length,
//         //       itemBuilder: (context, index) {
//         //         return ListTile(
//         //           title: Text("text"),
//         //           subtitle: Text("subtitle"),
//         //           onTap: () {},
//         //         );
//         //       },
//         //     );
//         //   } else if (snapshot.hasError) {
//         //     return Text("${snapshot.error}");
//         //   }
//         // },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class TestWidget extends StatefulWidget {
//   const TestWidget({Key? key}) : super(key: key);

//   @override
//   _TestWidgetState createState() => _TestWidgetState();
// }

// class _TestWidgetState extends State<TestWidget> {
//   final _formKey = GlobalKey<FormState>();

//   bool _showPassword = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Test Widget'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: EdgeInsets.only(
//             top: MediaQuery.of(context).size.height * 0.01,
//             left: MediaQuery.of(context).size.width * 0.05,
//             right: MediaQuery.of(context).size.width * 0.05,
//           ),
//           child: Column(children: [
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Full Name',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               validator: (value) {
//                 if (value!.length < 5) {
//                   return 'Please enter a valid name';
//                 } else {
//                   return null;
//                 }
//               },
//             ),
//             const SizedBox(height: 10),
//             TextFormField(
//               style: const TextStyle(
//                 fontSize: 20,
//               ),
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecoration(
//                 icon: const Icon(Icons.email),
//                 labelText: 'Email',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextFormField(
//               style: const TextStyle(
//                 fontSize: 20,
//               ),
//               obscureText: _showPassword,
//               keyboardType: TextInputType.visiblePassword,
//               decoration: InputDecoration(
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _showPassword ? Icons.visibility_off : Icons.visibility,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _showPassword = !_showPassword;
//                     });
//                   },
//                 ),
//                 icon: const Icon(Icons.lock),
//                 labelText: 'Password',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               height: 50,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.blue,
//               ),
//               child: GestureDetector(
//                 // onTap: () {
//                 //   print("signup");
//                 //   Navigator.push(
//                 //       context,
//                 //       MaterialPageRoute(
//                 //           builder: (context) => const HomeScreen()));
//                 // },
//                 child: const Text(
//                   'Sign Up',
//                   style: TextStyle(color: Colors.white, fontSize: 25),
//                 ),
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
