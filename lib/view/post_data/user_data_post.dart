// ignore_for_file: avoid_print
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:home_rental/controller/Elements/successful_mesage_screen.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PostData extends StatefulWidget {
  const PostData({Key? key}) : super(key: key);

  @override
  _PostDataState createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  File? imagePicked;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return const Text("Select Image");
      final imageTemp = File(image.path);
      // imageAddress = imageTemp.path;
      setState(() {
        imagePicked = imageTemp;
      });
      print(imagePicked);
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
    // return Text("data");
  }

  // Map? responseBody;
  final storage = const FlutterSecureStorage();

  Future uploadPosts() async {
    String? token = await storage.read(key: "token");
    var stream = http.ByteStream(imagePicked!.openRead());
    stream.cast();
    var length = await imagePicked?.length();

    final request = http.MultipartRequest(
        "POST", Uri.parse('https://homeforrent.herokuapp.com/posts/add'));
    request.headers["auth-token"] = "$token";
    request.fields["username"] = _username.text;
    request.fields["owner"] = _owner.text;
    request.fields["size"] = _size.text;
    request.fields["rent"] = _rent.text;
    request.fields["address"] = _address.text;
    request.fields["city"] = _city.text;
    request.fields["apartment"] = _apartment.text;
    request.fields["phone"] = _phone.text;
    request.fields["description"] = _description.text;
    request.fields["available"] = "true";

    var picture = http.MultipartFile('picture', stream, length!);
    request.files.add(picture);
    var response = await request.send();

    print(response.statusCode);

    if (response.statusCode == 200) {
      print("Image Uploaded");
      const snackBar = SnackBar(
        content: Text(
          "Image Uploaded",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        isLoading = false;
        EasyLoading.dismiss();
      });

      return Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SuccessfullMessage()));
    } else if (response.statusCode == 401) {
      print("Login Again--Token eXpired!");
      const snackBar = SnackBar(
        content: Text(
          "Login Again",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        isLoading = false;
      });
      return Navigator.pop(context);
    } else if (response.statusCode == 500) {
      print("Server Error");
      final snackBar = SnackBar(
        content: Text(
          "Server Error ${response.statusCode}",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        isLoading = false;
      });
      return Navigator.pop(context);
    }
    return Exception("Select image");
  }

  final TextEditingController _username = TextEditingController();
  final TextEditingController _owner = TextEditingController();
  final TextEditingController _size = TextEditingController();
  final TextEditingController _rent = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _apartment = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Your Information"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Center(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  imagePicked != null
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.35,
                          color: Colors.deepPurple[100],
                          child: Image.file(imagePicked!),
                        )
                      : Column(
                          children: const [
                            FlutterLogo(size: 200),
                            Text(
                              'You have not yet picked an image.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text('Camera'),
                        onPressed: () {
                          pickImage(ImageSource.camera);
                        },
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      ElevatedButton(
                        child: const Text('Gallery'),
                        onPressed: () {
                          pickImage(ImageSource.gallery);
                        },
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _username,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'kavish104',
                      labelText: 'Username *',
                    ),
                    maxLength: 15,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Username can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _owner,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person_search),
                      hintText: 'Kavish Baingane',
                      labelText: 'Owner Name *',
                    ),
                    maxLength: 20,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Owner name can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _size,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.donut_large),
                      hintText: '1200 sqft',
                      labelText: 'Room Size *',
                    ),
                    maxLength: 5,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Room size can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _rent,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.price_check),
                      hintText: '2000 Rs',
                      labelText: 'Rent *',
                    ),
                    maxLength: 5,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Rent can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _apartment,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.apartment),
                      hintText: 'Sai Sparsh',
                      labelText: 'Appartment *',
                    ),
                    maxLength: 25,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Apartment can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _address,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.location_pin),
                      hintText: 'H. 104, Surbhi Mohini, Awadhpuri',
                      labelText: 'Address *',
                    ),
                    maxLength: 30,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Address can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _city,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.location_searching),
                      hintText: 'Bhopal',
                      labelText: 'City *',
                    ),
                    maxLength: 30,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'City can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phone,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.phone),
                      hintText: '1234567890',
                      labelText: 'Phone No. *',
                    ),
                    maxLength: 10,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone number can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _description,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.description),
                      hintText: 'Description',
                      labelText: 'Description ',
                    ),
                    maxLength: 50,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Description can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final isValid = _formKey.currentState!.validate();
                      if (imagePicked == null) {
                        const snackBar = SnackBar(
                          content: Text(
                            "Please Upload Image",
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: Colors.redAccent,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      if (isValid && imagePicked != null) {
                        _formKey.currentState!.setState(() {
                          uploadPosts();
                        });
                        print("Upload Pressed");
                        setState(() {
                          isLoading = true;
                          EasyLoading.show(
                            status: 'loading...',
                            maskType: EasyLoadingMaskType.black,
                          );
                        });
                      } else {
                        print("Upload Failed");
                        const snackBar = SnackBar(
                          content: Text(
                            "Please Enter Details",
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: Colors.redAccent,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const Text("Upload"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
