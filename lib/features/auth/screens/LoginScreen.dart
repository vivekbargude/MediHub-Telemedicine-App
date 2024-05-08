import 'package:flutter/material.dart';
import 'package:medihub/features/auth/screens/SignupScreen.dart';
import 'package:medihub/constants/colors.dart';
import 'package:medihub/features/auth/services/auth_services.dart';

import '../widgets/LoginSuccess.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthServices authServices = AuthServices();
  final _signInFormKey = GlobalKey<FormState>();
  bool _isObscure = true; // Track password visibility

  void signInUser() {
    authServices.signIn(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Center(
            child: Text(
              'Login',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _signInFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Enter your email',
                      prefixIcon: Icon(Icons.mail_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your email";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 8.0), // Added SizedBox for spacing
                  GestureDetector(
                    onTap: () {
                      // Add logic to handle "Forgot Password?" action
                    },
                    child: Text(
                      'Forgot Password?',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.blue, // You can customize the color
                      ),
                    ),
                  ),

                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Enter your password',
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isObscure =
                                !_isObscure; // Toggle password visibility
                          });
                        },
                        child: Icon(_isObscure
                            ? Icons.visibility
                            : Icons
                                .visibility_off), // Toggle icon based on password visibility
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your password";
                      }
                      return null;
                    },
                    obscureText: _isObscure, // Toggle password visibility
                  ),

                  SizedBox(height: 32.0),
                  Container(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bgColor,
                      ),
                      onPressed: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => LoginSuccess(),
                        //   ),
                        // );

                        if (_signInFormKey.currentState!.validate()) {
                          signInUser();
                        }
                        print('login');
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  SizedBox(height: 8.0), // Added SizedBox for spacing
                  Center(
                    // Center alignment for the row
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t have an account? ',
                          textAlign: TextAlign.center,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    SignupScreen(), // Replace HomeScreen with your home screen
                              ),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blue, // You can customize the color
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.0), // Added SizedBox for spacing
                  Column(
                    children: [
                      Container(
                        width: 400,
                        height: 50,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300], // Greyish color
                          ),
                          onPressed: () {
                            // Implement logic for signing in with Google
                          },
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Image.asset('assets/google.png', height: 24),
                          ), // Replace with Google logo asset
                          label: Text('Sign in with Google',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: 400,
                        height: 50,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300], // Greyish color
                          ),
                          onPressed: () {
                            // Implement logic for signing in with Apple
                          },
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Image.asset('assets/apple-logo.png',
                                height: 24),
                          ), // Replace with Apple logo asset
                          label: Text('Sign in with Apple',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: 400,
                        height: 50,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300], // Greyish color
                          ),
                          onPressed: () {
                            // Implement logic for signing in with Facebook
                          },
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child:
                                Image.asset('assets/facebook.png', height: 24),
                          ),
                          label: Text('Sign in with Facebook',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
