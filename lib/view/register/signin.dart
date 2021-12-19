// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
    required this.toggle,
  }) : super(key: key);

  final Function toggle;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  Map? message;
  String? messageData;

  bool _showPassword = true;

  Future signInApiPost() async {
    final response = await http.post(
      Uri.parse("https://homeforrent.herokuapp.com/profile/signin"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'email': email,
          'password': password,
        },
      ),
    );

    setState(() {
      message = jsonDecode(response.body);
      messageData = message!['message'].toString();
      print(message);
    });
    // if (response.statusCode == 200) {
    //   return Navigator.pushNamed(context, '/home');
    // }
    final snackBar = SnackBar(
      content: Text('$email \n$messageData'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if (response.statusCode == 200) {
      return Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 40, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome,',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const Text(
                      'Sign in to continue!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Image(
                        width: 2 * MediaQuery.of(context).size.width * 0.3,
                        image: const AssetImage('assets/images/blue-house.gif'),
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Column(children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.email),
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
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
                    const SizedBox(height: 20),
                    TextFormField(
                      // style: const TextStyle(
                      //   fontSize: 20,
                      // ),
                      obscureText: _showPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
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
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          final isValid = _formKey.currentState!.validate();
                          if (isValid) {
                            _formKey.currentState!.setState(() {
                              signInApiPost();
                            });
                            print("OK");
                            // final snackBar = SnackBar(
                            //   content: Text(
                            //       '$email \n${message!['message'].toString()}'),
                            // );
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(snackBar);

                            // Navigator.pushNamed(context, '/home');

                          } else {
                            print("Error");
                          }
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Sign In with other account.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () => print('Google'),
                    child: const Image(
                      image: AssetImage('assets/images/google-logo.png'),
                      height: 50,
                      width: 80,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => print('Twitter'),
                    child: const Image(
                      image: AssetImage('assets/images/twitter.png'),
                      height: 50,
                      width: 80,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.toggle();
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
