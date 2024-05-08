import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medihub/features/cart/screens/cart_screen.dart';
import 'package:medihub/features/pharmacy/screens/productSelected.dart';
import 'package:medihub/features/pharmacy/services/pharmacy_services.dart';
import 'package:medihub/features/pharmacy/services/productModel.dart';
import 'package:medihub/utils/customBanner.dart';

class VerticalList extends StatefulWidget {
  const VerticalList({Key? key}) : super(key: key);

  static const String routeName = "pharmacy";
  

  @override
  State<VerticalList> createState() => _VerticalListState();
}

class _VerticalListState extends State<VerticalList> {

   List<Pharmacy>? pharmacyList;
   final PharmacyServices pharmacyServices = PharmacyServices();

  @override
  void initState() {
    super.initState();
    fetchPharmacy();
  }

  fetchPharmacy() async
  {

    pharmacyList = await pharmacyServices.getMedicines(context: context);
    // print(pharmacyList);
    setState(() {
    
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy'),
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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 5, left: 20, right: 20),
            child: SearchBar(
              leading: Icon(Icons.search),
              hintText: "Search doctor, drug, article...",
            ),
          ),
          CustomBanner(
            text: 'Order quickly with \nPrescription',
            buttonText: 'Upload Prescription',
            imagePath: 'assets/contractrqe 1.png',
            onPressed: () {
              // Add your button action here
            },
          ),
          const SizedBox(height: 20),
          pharmacyList == null ? Center(child: const CircularProgressIndicator()) : Column(
            children: [
              SizedBox(
                      height: 250,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 15),
                        itemCount: pharmacyList!.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1.4,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          final product = pharmacyList![index];
                          return GestureDetector(
                            onTap: () {
                            String medName = product.medName;
                            Navigator.pushNamed(context, ProductSelected.routeName,arguments: medName);
                          
                            },
                            child: Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 130,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black12,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.network(
                                          product.medImage, // Assuming medImage is a list of URLs
                                          // 'https://res.cloudinary.com/drerbcnk2/image/upload/v1710949047/koinoybmpsctvbccc8kv.png'
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.only(
                                      left: 0,
                                      top: 5,
                                      right: 15,
                                    ),
                                    child: Text(
                                      product.medName,
                                      maxLines: 1,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.only(
                                      left: 0,
                                      top: 5,
                                      right: 15,
                                    ),
                                    child: Text(
                                      '${product.medQuantity}ml',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '₹${product.medPrice}',
                                      ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          // Add your onPressed action here
                                        },
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

            ],
          ) 
        ],
      ),
    );
  }
}

//   Widget _buildProductCard(Pharmacy product) {
//     return Container(
//       width: 120,
//       height: 200, // Increased height
//       margin: const EdgeInsets.only(right: 10),
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.network(
//                 product.imageUrl,
//                 height: 120,
//                 width: 120,
//                 fit: BoxFit.cover,
//               ),
//               const SizedBox(height: 5),
//               Text(product.name),
//               Text(product.pcs),
//               Text(product.price),
//             ],
//           ),
//           Positioned(
//             bottom: -5,
//             right: -5,
//             child: IconButton(
//               onPressed: () {
//                 // Add your button action here
//               },
//               icon: const Icon(Icons.add),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
