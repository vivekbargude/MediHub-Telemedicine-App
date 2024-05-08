import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:medihub/utils/helper.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as location;
import 'dart:convert';
// import 'package:flutter_sms/flutter_sms.dart';


class EmergencyServices {
  location.LocationData? _currentLocation;

  Future<void> requestPermissions() async {
    await permission_handler.Permission.location.request();
    await permission_handler.Permission.phone.request();
  }

  Future<void> getCurrentLocation() async {
    var locationService = location.Location();
    bool serviceEnabled = await locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationService.requestService();
      if (!serviceEnabled) {
        // Handle if user denies enabling location services
        return;
      }
    }

    var permission = await permission_handler.Permission.location.status;
    if (permission != permission_handler.PermissionStatus.granted) {
      permission = await permission_handler.Permission.location.request();
      if (permission != permission_handler.PermissionStatus.granted) {
        // Handle if user denies location permission
        return;
      }
    }

    _currentLocation = await locationService.getLocation();
  }

  // Getter method to access _currentLocation
  location.LocationData? getCurrentLocationData() {
    return _currentLocation;
  }

  Future<String?> getAddress(double? latitude, double? longitude) async {
  final url =
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final displayName = decoded['display_name'];
      final mapLink = 'https://www.openstreetmap.org/?mlat=$latitude&mlon=$longitude';
      print('$displayName\n\nLocation: $mapLink');
      return '$displayName\n\nLocation: $mapLink';
    }
  } catch (e) {
    print('Error getting address: $e');
  }
  return null;
}

// void _sendSMS(String message, List<String> recipents) async {
//  String _result = await sendSMS(message: message, recipients: recipents)
//         .catchError((onError) {
//       print(onError);
//     });
// print(_result);
// }


Future<List<Hospital>> fetchNearbyHospitals(LatLng location) async {
  // Construct the Overpass QL query
  final String query = """
    [out:json];
    (
      node["amenity"="hospital"](around:5000,${location.latitude},${location.longitude});
      way["amenity"="hospital"](around:5000,${location.latitude},${location.longitude});
      relation["amenity"="hospital"](around:5000,${location.latitude},${location.longitude});
    );
    out center;
  """;

  // Encode the query
  final String encodedQuery = Uri.encodeComponent(query);

  // Define the Overpass API endpoint URL
  final String apiUrl = 'https://overpass-api.de/api/interpreter';

  try {
    // Send an HTTP POST request to the Overpass API
    final http.Response response = await http.post(Uri.parse(apiUrl), body: 'data=$encodedQuery');

    if (response.statusCode == 200) {
      // Parse the response JSON
      final List<dynamic> data = jsonDecode(response.body)['elements'];

      // Extract hospital data and convert to Hospital objects
      List<Hospital> hospitals = [];
      for (var element in data) {
        final String name = element['tags']['name'] ?? 'Unknown Hospital'; // Default name if not provided
        final double lat = element['lat'];
        final double lon = element['lon'];
        hospitals.add(Hospital(name: name, location: LatLng(lat, lon)));
      }

      return hospitals;
    } else {
      throw Exception('Failed to fetch hospitals');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<bool> sendMessage(String? token,String emergencyNumber, String messageBody) async {
  final String apiUrl = '$uri/api/send-message'; // Replace with your API URL

  // Replace the placeholders with your actual Twilio credential

  try {
    // Construct the request body
    final Map<String, dynamic> requestBody = {
      'emergencyNumber': emergencyNumber,
      'messageBody': messageBody,
    };

    // Encode the request body to JSON
    final String encodedBody = json.encode(requestBody);

    // Make the POST request to the API endpoint
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-auth-token': token!,
      },
      body: encodedBody,
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      print('Message sent successfully');
      return true;
    } else {
      // Print the error message if the request was not successful
      print('Error: ${response.body}');
      return false;
    }
  } catch (error) {
    // Print any exceptions that occur during the process
    print('Error: $error');
    return false;
  }
}


}




class Hospital {
  final String name;
  final LatLng location;

  Hospital({
    required this.name,
    required this.location,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    final String name = json['tags']['name'] ?? 'Unknown Hospital';
    final double lat = json['lat'];
    final double lon = json['lon'];
    return Hospital(
      name: name,
      location: LatLng(lat, lon),
    );
  }

  @override
  String toString() {
    return 'Hospital(name: $name, location: $location)';
  }
}