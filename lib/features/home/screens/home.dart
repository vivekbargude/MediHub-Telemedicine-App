import 'package:flutter/material.dart';
import 'package:medihub/features/chat/screen/chat.dart';
import 'package:medihub/constants/colors.dart';
import 'package:medihub/features/news/pages/home.dart';
import 'package:medihub/features/schedule/screen/schedule.dart';
import 'package:medihub/features/home/screens/home1.dart';
import 'package:medihub/features/profile/screens/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Define your pages here
  final List<Widget> _pages = [
    // Replace these with your actual pages
    Home1(),
    Home(),
    Schedule(),
    ProfileTwoPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '', // Empty string for no text
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: bgColor, // Color for selected icon
        unselectedItemColor: Colors.grey, // Color for unselected icons
        onTap: _onItemTapped,
        showSelectedLabels: false, // Hide labels
        showUnselectedLabels: false, // Hide labels
      ),
    );
  }
}
