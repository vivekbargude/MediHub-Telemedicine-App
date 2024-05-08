import 'package:flutter/material.dart';
import 'package:medihub/constants/colors.dart';

class CustomBanner extends StatelessWidget {
  final String text;
  final String buttonText;
  final String imagePath;
  final VoidCallback onPressed;

  const CustomBanner({
    required this.text,
    required this.buttonText,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        width: 335,
        height: 135,
        decoration: BoxDecoration(
            color: shadowColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8.0, top: 15),
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Container(
                      width: 115,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: bgColor,
                        ),
                        child: Center(
                          child: Text(
                            buttonText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(width: 130, height: 200, child: Image.asset(imagePath)),
            ],
          ),
        ),
      ),
    );
  }
}
