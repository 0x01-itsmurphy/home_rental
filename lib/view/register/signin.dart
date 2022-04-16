// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_rental/controller/Elements/custom_outlined_button.dart';
import 'package:home_rental/controller/Elements/custom_text_button.dart';
import 'package:home_rental/controller/authentication/google_signin_authenticator.dart';
import 'package:home_rental/controller/loading.dart';
import 'package:home_rental/controller/provider/google_signin_provider.dart';
import 'package:home_rental/view/homescreen/homescreen.dart';
import 'package:home_rental/view/register/widgets/bottom_text_switchpage_widget.dart';
import 'package:home_rental/view/register/widgets/heading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

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

  bool loading = false;

  String email = '';
  String password = '';

  Map? message;
  String? token;
  String? messageData;
  String? userProfile;

  final storage = const FlutterSecureStorage();

  bool _showPassword = true;

  // get isLoading => null;

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

    message = jsonDecode(response.body);
    messageData = message!['message'].toString();
    userProfile = message!['user'].toString();

    token = message!['token'].toString();
    await storage.write(key: "token", value: token);

    print("Json --> $message");
    print("MessageDecoded --> $messageData");
    print("UserProfile --> $userProfile");
    print("Token --> $token");

    // if (response.statusCode == 200) {
    //   return Navigator.pushNamed(context, '/home');
    // }
    final snackBar = SnackBar(
      content: Text('$email \n$messageData'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {
      loading = false;
    });

    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      return Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
                  title: 'Welcome,',
                  subTitle: 'Sign in to continue!',
                  image: AssetImage('assets/images/blue-house.gif'),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 10),
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
                        obscureText: _showPassword,
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
                      CustomTextButton(
                        text: 'Sign In',
                        isLoading: loading,
                        onTap: () {
                          final isValid = _formKey.currentState!.validate();
                          if (isValid) {
                            _formKey.currentState!.setState(() {
                              signInApiPost();
                            });
                            print("SignIn Button Clicked");
                            setState(() {
                              loading = true;
                            });
                          } else {
                            print("Error fetching Api");
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
                  firstText: 'Don\'t have an account?',
                  secondText: 'Register',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
