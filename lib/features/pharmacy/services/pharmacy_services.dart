import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medihub/constants/error_handler.dart';
import 'package:medihub/constants/utils.dart';
import 'package:medihub/features/pharmacy/services/productModel.dart';
import 'package:http/http.dart' as http;
import 'package:medihub/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PharmacyServices {

  Future<List<Pharmacy>> getMedicines({required BuildContext context}) async {
    List<Pharmacy> pharmacyList = [];

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/get-pharmacy'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(response.body);
      httpErrorHanlder(
        response: response,
        context: context,
        onSuccess: () {
          // Access the "medicines" array from the response
          List<dynamic> jsonData = jsonDecode(response.body)['medicines'];
          // Map the "medicines" array to Pharmacy objects
          pharmacyList = jsonData.map((data) => Pharmacy.fromMap(data)).toList();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return pharmacyList;
  }

 Future<Pharmacy> getMedicineDetails({required String medName, required BuildContext context}) async {
  try {
    final response = await http.get(
      Uri.parse('$uri/api/medicine-details?medName=$medName'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      Pharmacy medicineDetails = Pharmacy.fromMap(jsonData['data']);
      return medicineDetails; // Return the fetched medicine details
    } else {
      showSnackBar(context, 'Failed to fetch medicine details');
      throw Exception('Failed to fetch medicine details'); // Throw an exception to handle failure
    }
  } catch (e) {
    showSnackBar(context, 'Error: $e');
    throw Exception('Error fetching medicine details: $e'); // Throw an exception to handle errors
  }
}


}
