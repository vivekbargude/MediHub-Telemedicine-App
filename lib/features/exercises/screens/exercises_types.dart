import 'package:flutter/material.dart';
import 'package:medihub/features/exercises/screens/exercises_list.dart';
import 'package:medihub/features/exercises/widgets/exercise_card.dart';

class ExerciseTypes extends StatefulWidget {
  static const String routeName = '/exercise-types';
  const ExerciseTypes({super.key});

  @override
  State<ExerciseTypes> createState() => _ExerciseTypesState();
}

class _ExerciseTypesState extends State<ExerciseTypes> {

  List<String> exerciseTypes = [
    'Abdominals',
    'Abductors',
    'Adductors',
    'Biceps',
    'Calves',
    'Chest',
    'Forearms',
    'Glutes',
    'Hamstrings',
    'Lats',
    'Lower_back',
    'Middle_back',
    'Neck',
    'Quadriceps',
    'Traps',
    'Triceps'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Exercises"),
      ),

      body: ListView.builder(
        itemCount: exerciseTypes.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print(exerciseTypes[index]);
              Navigator.pushNamed(context, ExerciseList.routeName,arguments: exerciseTypes[index]);
            },
            child: ExerciseCard(name: exerciseTypes[index]),
          );
        },
      ),
    );
  }
}
