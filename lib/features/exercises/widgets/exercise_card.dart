import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  final String name;

  const ExerciseCard({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Center(
        child: ListTile(
          title: Text(
            name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
