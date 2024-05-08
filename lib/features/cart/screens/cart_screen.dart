import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medihub/features/cart/models/cart.dart';
import 'package:medihub/features/cart/services/cart_services.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PharmacyCart extends StatefulWidget {
  const PharmacyCart({Key? key}) : super(key: key);

  static const String routeName = "pharmacyCart";

  @override
  State<PharmacyCart> createState() => _PharmacyCartState();
}

class _PharmacyCartState extends State<PharmacyCart> {

  Cart? fetchedCart ;
  final CartServices cartServices = CartServices();
  String? authToken;

  @override
  void initState() {
    super.initState();
   fetcheUserCart();
  }

  void fetcheUserCart()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    authToken = sharedPreferences.getString('x-auth-token');
    if(authToken!=null)
    {
      fetchedCart = await cartServices.fetchCartDetails(authToken);
    print(fetchedCart);
    setState(() {
           
    });
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('My Cart'),
      centerTitle: true,
    ),
    body: fetchedCart == null
      ? const Center(child: CircularProgressIndicator())
      : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: fetchedCart!.userCart.length,
              itemBuilder: (context, index) {
                final item = fetchedCart!.userCart[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Image.network(
                              item.pharmacy.medImage,
                              height: 100,
                              width: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.pharmacy.medName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${item.pharmacy.medQuantity}ml",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '\₹${item.pharmacy.medPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Quantity : ${item.quantity}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Implement delete logic
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 100,
            color: Colors.grey[200],
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$100', // You can calculate the total based on the fetchedCart
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement payment logic
                  },
                  child: const Text('Pay', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
  );
}

}
