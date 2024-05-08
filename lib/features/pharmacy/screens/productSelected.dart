import 'package:flutter/material.dart';
import 'package:medihub/constants/colors.dart';
import 'package:medihub/features/cart/services/cart_services.dart';
import 'package:medihub/features/cart/screens/cart_screen.dart';
import 'package:medihub/features/pharmacy/services/pharmacy_services.dart';
import 'package:medihub/features/pharmacy/services/productModel.dart';
import 'package:medihub/utils/splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductData extends ChangeNotifier {
  int _quantity = 1;

  int get quantity => _quantity;

  void incrementQuantity() {
    _quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }
}

class ProductSelected extends StatefulWidget {
  final String medName;
  const ProductSelected({Key? key,required this.medName}) : super(key: key);

  static const String routeName = "productSelected";

  @override
  State<ProductSelected> createState() => _ProductSelectedState();
}

class _ProductSelectedState extends State<ProductSelected> {

  Pharmacy? pharmacy;
  final PharmacyServices pharmacyServices = PharmacyServices();
  final CartServices cartServices = CartServices();
  String? authToken;

  @override
  void initState(){
    super.initState();
    fetchPharmacyDetails();
    fetchToken();
  }

  fetchPharmacyDetails() async{
    pharmacy = await pharmacyServices.getMedicineDetails(medName: widget.medName, context: context); 
    setState(() {

    });
  }

  void fetchToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    authToken = sharedPreferences.getString('x-auth-token');
    // Get the token from shared preferences
  }


  void addPharmacyToCart(String productId, String authToken) async {
  await cartServices.addToCart(authToken,productId);

}


  @override
  Widget build(BuildContext context) {
    var productData = Provider.of<ProductData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drugs Detail'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, PharmacyCart.routeName);
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: pharmacy==null? const Center(child: CircularProgressIndicator()) :SingleChildScrollView(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (pharmacy != null) // Check if pharmacy is not null
        Image.network(
          pharmacy!.medImage, // Access medImage using the null check operator
          height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.medName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (pharmacy != null) // Check if pharmacy is not null
              Text(
                '${pharmacy!.medQuantity.toString()}ml', // Access medQuantity using the null check operator
              ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    productData.decrementQuantity();
                  },
                  icon: const Icon(Icons.remove),
                  color: bgColor, // Set the color of the icon
                  splashRadius: 20, // Set the splash radius
                  iconSize: 24, // Set the icon size
                ),
                Text('${productData.quantity}'),
                IconButton(
                  onPressed: () {
                    productData.incrementQuantity();
                  },
                  icon: const Icon(Icons.add),
                  color: bgColor, // Set the color of the icon
                  splashRadius: 20, // Set the splash radius
                  iconSize: 24, // Set the icon size
                ),
                const SizedBox(
                  width: 180,
                ),
                if (pharmacy != null) // Check if pharmacy is not null
                  Text(
                    '₹${pharmacy!.medPrice.toString()}', // Access medPrice using the null check operator
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24, // Set the font size to make it big
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Description',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              pharmacy!.medDesc,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity, // Set width to match parent
              child: ElevatedButton.icon(
                onPressed: () {
                  addPharmacyToCart(pharmacy!.id, authToken!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      bgColor, // Use bgColor as the button's background color
                ),
                icon:const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ), // Add cart icon
                label: const Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),
    );
  }
}
