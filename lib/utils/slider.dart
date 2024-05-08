import 'package:flutter/material.dart';
import 'package:medihub/constants/colors.dart';
import 'package:medihub/utils/welcome.dart';

import '../features/home/screens/home.dart';

class SliderScreen extends StatefulWidget {
  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildScreen1(),
              _buildScreen2(),
              _buildScreen3(),
              // _buildScreen(2, Colors.green),
              // _buildScreen(3, Colors.orange),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3, // Number of pages
                    (index) => _buildDot(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int pageIndex) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      height: 10.0,
      width: _currentPage == pageIndex ? 30.0 : 10.0,
      decoration: BoxDecoration(
        color: _currentPage == pageIndex ? bgColor : Colors.grey,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }

  Widget _buildScreen1() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/D1.png', // Replace 'image1.png' with your image path
              width: 450,
              height: 450,
            ),
            SizedBox(height: 20),
            Text(
              'Consult only with a doctor \n                you trust',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreen2() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/D2.png', // Replace 'image1.png' with your image path
              width: 450,
              height: 450,
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Find a lot of specialist doctors in one place',
                style: TextStyle(fontSize: 24, color: Colors.black),
                textAlign: TextAlign.center, // Align the text center
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildScreen3() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/D3.png', // Replace 'image1.png' with your image path
              width: 400,
              height: 400,
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Get connect our Online Consultation',
                style: TextStyle(fontSize: 24, color: Colors.black),
                textAlign: TextAlign.center, // Align the text center
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navigate to home screen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(), // Replace HomeScreen with your home screen
                  ),
                );
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildScreen(int number, Color color) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          'Screen $number',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
