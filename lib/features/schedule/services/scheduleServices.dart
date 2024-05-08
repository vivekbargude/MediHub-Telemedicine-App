import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medihub/features/schedule/models/appointment.dart';
import 'package:medihub/utils/helper.dart';


class ScheduleServices{

  Future<List<Appointment>?> getAppointments(String? authToken) async {
  final String apiUrl = '$uri/api/get-appointments';

  try {
    
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': authToken!},
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> appointmentsJson = data['data'];

      // Map the JSON data to Appointment objects using the factory method
      final List<Appointment> appointments = appointmentsJson
          .map((json) => Appointment.fromJson(json))
          .toList();

      return appointments;
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load appointments');
    }
  } catch (error) {
    // Catch any errors that occur during the HTTP request
    throw Exception('Failed to load appointments: $error');
  }
}

}