import 'package:http/http.dart' as http;
import 'package:medihub/features/cart/models/cart.dart';
import 'package:medihub/utils/helper.dart';
import 'dart:convert';

class CartServices{


  Future<void> addToCart(String token, String productId) async {
  // Define the API endpoint
  String apiUrl = '$uri/api/add-to-cart';

  // Prepare the request headers
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'x-auth-token': token,
  };

  // Prepare the request body
  Map<String, dynamic> body = {'id': productId};

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
      print('Cart: $responseData');
    } else {
      // If the request was not successful, print the error message
      print('Failed to add to cart. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Catch any errors that occur during the request
    print('Error adding to cart: $e');
  }
}


Future<Cart> fetchCartDetails(String? token) async {

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'x-auth-token': token!,
  };

  final response = await http.get(
    Uri.parse('$uri/api/get-cart'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    print(response.body);
    return Cart.fromMap(jsonDecode(response.body)['cart']);
  } else {
    throw Exception('Failed to load cart details');
  }
}



}