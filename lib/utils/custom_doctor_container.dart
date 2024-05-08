import 'package:flutter/material.dart';
import 'package:medihub/features/doctor/catDoctor/screens/doctor_vertical.dart';
import 'package:medihub/features/doctor/doctor.dart';

class CustomDoctorContainer extends StatelessWidget {
  final String text;
  final String imagePath;
  // final String routeName;

  const CustomDoctorContainer({
    Key? key,
    required this.text,
    required this.imagePath,
    // required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          if(text!=null) { 
            onCustomContainerTap(text);
            Navigator.pushNamed(context, DoctorVertical.routeName,arguments: text);
          }
        },
        child: Container(
          height: 84,
          width: 65,
          decoration: BoxDecoration(
            color: Colors.white, // Set the background color
            borderRadius: BorderRadius.circular(8), // Add rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Grey color with opacity
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: Offset(0, 3), // Offset
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 32, height: 32),
              SizedBox(height: 10),
              Text(
                text,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
