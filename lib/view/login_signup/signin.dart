// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:home_rental/view/homescreen/homescreen.dart';
import 'package:home_rental/view/login_signup/signup.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
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
                    const EmailFiled(),
                    const SizedBox(height: 20),
                    const PasswordField(),
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
                            _formKey.currentState!.save();

                            final snackBar = SnackBar(
                              content: Text('$password \n $email'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () => print('Google'),
                    child: const Image(
                      image: AssetImage('assets/images/google-logo.png'),
                      height: 80,
                      width: 50,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => print('Twitter'),
                    child: const Image(
                      image: AssetImage('assets/images/twitter.png'),
                      height: 80,
                      width: 50,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                      child: const Text(
                        "Register",
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

class EmailFiled extends StatefulWidget {
  const EmailFiled({
    Key? key,
  }) : super(key: key);

  @override
  State<EmailFiled> createState() => _EmailFiledState();
}

class _EmailFiledState extends State<EmailFiled> {
  String email = '';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: const Icon(Icons.email),
        labelText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
        final regExp = RegExp(pattern);
        if (value!.isEmpty) {
          return 'Enter email';
        } else if (!regExp.hasMatch(value)) {
          return 'Enter valid email';
        } else {
          return null;
        }
      },
      onSaved: (value) => setState(() {
        email = value!;
      }),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  String password = '';
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // style: const TextStyle(
      //   fontSize: 20,
      // ),
      obscureText: _showPassword,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            _showPassword ? Icons.visibility_off : Icons.visibility,
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
      onSaved: (value) => setState(() {
        password = value!;
      }),
    );
  }
}
