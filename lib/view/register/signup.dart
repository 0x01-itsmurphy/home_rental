// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_rental/controller/Elements/custom_outlined_button.dart';
import 'package:home_rental/controller/Elements/custom_text_button.dart';
import 'package:home_rental/controller/authentication/google_signin_authenticator.dart';
import 'package:home_rental/controller/authentication/toggle_page_switch.dart';
import 'package:home_rental/controller/provider/google_signin_provider.dart';
import 'package:home_rental/view/register/signin.dart';
import 'package:home_rental/view/register/widgets/bottom_text_switchpage_widget.dart';
import 'package:home_rental/view/register/widgets/heading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, required this.toggle}) : super(key: key);

  final Function toggle;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String username = '';
  String email = '';
  String password = '';

  Map? message;
  String? messageData;

  bool _showPassword = true;
  bool toggle = false;

  Future registerApiPost() async {
    final response = await http.post(
      Uri.parse("https://$baseUrl/profile/signup"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'username': username,
          'email': email,
          'password': password,
        },
      ),
    );

    setState(() {
      message = jsonDecode(response.body);
      print("Response body --> ${response.body}");
      messageData = message!['message'].toString();
      print("Message --> $message");
    });

    final snackBar = SnackBar(
      content: Text(
        '$email \n$messageData',
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {
      loading = false;
    });

    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const AuthPageToggleSwitch()));
    } else if (response.statusCode == 500) {
      final snackBar = SnackBar(
        content: Text('$email \n$messageData',
            style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                const HeadingWidget(
                  title: 'Create Account,',
                  subTitle: 'Sign up to get started!',
                  image: AssetImage('assets/images/blue-house.gif'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 10),
                          icon: const Icon(Icons.person),
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        maxLength: 30,
                        validator: (value) {
                          if (value!.length < 5) {
                            return 'Please enter a valid username';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) => setState(() {
                          username = value;
                        }),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 10),
                          icon: const Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          const pattern =
                              r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
                          final regExp = RegExp(pattern);
                          if (value!.isEmpty) {
                            return 'Enter email';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Enter valid email';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) => setState(() {
                          email = value;
                        }),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 10),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                          icon: const Icon(Icons.lock),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        obscureText: _showPassword,
                        validator: (value) {
                          if (value!.length < 8) {
                            return 'Please enter more than 8 charater password';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) => setState(() {
                          password = value;
                        }),
                      ),
                      const SizedBox(height: 20),
                      CustomTextButton(
                        isLoading: loading,
                        text: 'Sign Up',
                        onTap: () {
                          final isValid = _formKey.currentState!.validate();
                          if (isValid) {
                            _formKey.currentState!.setState(() {
                              registerApiPost();
                              print("object");
                            });
                            print("sign up clicked");
                            setState(() {
                              loading = true;
                            });
                          } else {
                            print("Please Register");
                          }
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Sign In with other account.',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomOutlinedButton(
                      onPressed: () {
                        provider.googleLognIn().then((value) =>
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GoogleSignInAuthenticator())));
                      },
                      image: const AssetImage('assets/images/google-logo.png'),
                    ),
                    CustomOutlinedButton(
                      onPressed: () {},
                      image: const AssetImage('assets/images/twitter.png'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                BottomTextSwitch(
                  onPressed: () => widget.toggle(),
                  firstText: 'Already have an account?',
                  secondText: 'Sign In',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
