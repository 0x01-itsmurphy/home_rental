// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({
    Key? key,
    required this.toggle,
  }) : super(key: key);

  final Function toggle;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';

  Map? message;
  String? messageData;

  bool _showPassword = true;

  Future registerApiPost() async {
    final response = await http.post(
      Uri.parse("http://192.168.1.4:8000/api/auth/signup"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'name': name,
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
                      'Create Account,',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const Text(
                      'Sign up to get started!',
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
              const SizedBox(
                height: 20,
              ),
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
                      decoration: InputDecoration(
                        icon: const Icon(Icons.person),
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      maxLength: 30,
                      validator: (value) {
                        if (value!.length < 5) {
                          return 'Please enter a valid name';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) => setState(() {
                        name = value;
                      }),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
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
                      // style: const TextStyle(
                      //   fontSize: 20,
                      // ),
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
                              registerApiPost();
                              print("object");
                            });
                            print("sign up clicked");
                          } else {
                            print("Error");
                          }
                        },
                        // onTap: () {
                        //   print("signup");
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => const HomeScreen()));
                        // },
                        child: const Text(
                          'Sign Up',
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
                  'Sign Up with -',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () => print('Google'),
                    child: const Image(
                      image: AssetImage('assets/images/google-logo.png'),
                      height: 50,
                      width: 90,
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        widget.toggle();
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
