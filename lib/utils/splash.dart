import 'package:flutter/material.dart';
import 'package:medihub/constants/colors.dart';
import 'package:medihub/features/home/screens/home1.dart';
import 'package:medihub/utils/slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? authToken='';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // WidgetsFlutterBinding.ensureInitialized();
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // authToken = sharedPreferences.getString('x-auth-token');

    // // Add a delay to simulate the splash screen
    // if(authToken != null){

    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => Home1(), // Replace HomeScreen with your desired screen
    //     ),
    //   );
    // }
    // else
    // {
      Future.delayed(Duration(seconds: 5), () {
      // Navigate to the home screen after the delay
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SliderScreen(), // Replace HomeScreen with your desired screen
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            color: bgColor,
          ),
          child: Center(
            child: Image(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.2,
              image: AssetImage("assets/Logo.png"),
            ),
          ),
        ),
      ),
    );
  }
}
