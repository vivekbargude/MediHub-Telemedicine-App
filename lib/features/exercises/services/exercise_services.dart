import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medihub/models/exercise.dart';
import 'package:http/http.dart' as http;

class ExerciseServices {

  Future<List<Exercise>> fetchExercises(String keyword, String apiKey) async {
  final String apiUrl = 'https://api.api-ninjas.com/v1/exercises?muscle=$keyword';
  List<Exercise> exercises = [];
  
  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'X-Api-Key': apiKey},
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      List<dynamic> data = json.decode(response.body);
      // Process the data and convert it to a list of Exercise objects
      exercises = data.map((exerciseJson) => Exercise.fromJson(exerciseJson)).toList();
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load exercises: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching exercises: $e');
  }
  return exercises;
}

}