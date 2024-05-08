import 'package:flutter/material.dart';
import 'package:medihub/constants/colors.dart';

import '../features/auth/screens/LoginScreen.dart';
import '../features/auth/screens/SignupScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Logo.png',
                color: bgColor,
                width: 100,
                height: 100,
              ),
              SizedBox(height: 20),
              Text(
                'Let’s get started!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Login to enjoy the features we’ve provided, and stay healthy!',
                style: TextStyle(fontSize: 15,),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(bgColor),),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(), // Replace HomeScreen with your home screen
                      ),
                    );
                  },
                  child: Text('Login', style: TextStyle(color: Colors.white),),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(), // Replace HomeScreen with your home screen
                      ),
                    );
                  },
                  child: Text('Sign Up',  style: TextStyle(color: bgColor),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
