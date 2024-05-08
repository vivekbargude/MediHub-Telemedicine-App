import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medihub/utils/helper.dart'; // Import your helper file here

class BookDocServices {

  Future<bool> bookappointments(String? token, String doctorId, String timeslotId, String date) async {
    // Define the API endpoint
    String apiUrl = '$uri/api/book-appointment';

    // Prepare the request headers
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': token!,
    };

    // Prepare the request body
    Map<String, dynamic> body = {
      "doctorId": doctorId,
      "timeslotId": timeslotId,
      "date": date
    };

    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the response JSON
        Map<String, dynamic> responseData = jsonDecode(response.body);
        // Do something with the response data
        print('Response data: $responseData');
        return true;
      } else {
        // If the request was not successful, print the error message
        print('Failed to book appointment. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Catch any errors that occur during the request
      print('Error booking appointment: $e');
      return false;
    }
  }
}
