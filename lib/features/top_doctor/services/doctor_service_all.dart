import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:medihub/models/doctor.dart';
import 'package:medihub/utils/helper.dart';

class DoctorServiceAll {
  
  Future<List<Doctor>> fetchDoctors() async {
  try {
    // Make a GET request to the API endpoint with the specified category
    final response = await http.get(
        Uri.parse('$uri/api/get-doctors'),
        headers: {'Content-Type': 'application/json'},
      );
    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the JSON response body
      final List<dynamic> data = jsonDecode(response.body)['data'];
      print("response : $data");
      // Map the JSON data to Doctor objects
      List<Doctor> doctors = data.map((json) => Doctor.fromJson(json)).toList();
      
      return doctors; // Return the list of doctors
    } else {
      // If the request was not successful, throw an exception
      throw Exception('Failed to fetch doctors: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any errors that occur during the request
    throw Exception('Error fetching doctors: $e');
  }
  }
}
