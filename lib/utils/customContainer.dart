import 'package:flutter/material.dart';
import 'package:medihub/features/doctor/doctor.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final String imagePath;
  final String routeName;

  const CustomContainer({
    Key? key,
    required this.text,
    required this.imagePath,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (text != null) {
          onCustomContainerTap(text);
          Navigator.pushNamed(context, routeName);
        }
      },
      child: Container(
        height: 90,
        width: 78,
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 32, height: 32),
            SizedBox(height: 5),
            Text(
              text,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomContainerWrap extends StatelessWidget {
  final List<CustomContainer> containers;

  const CustomContainerWrap({Key? key, required this.containers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: containers,
    );
  }
}
