import 'package:medihub/features/cart/models/cart_item.dart';
import 'package:medihub/features/pharmacy/services/productModel.dart';
import 'dart:convert';

class Cart {
  String id;
  String userId;
  List<UserCartItem> userCart;

  Cart({
    required this.id,
    required this.userId,
    required this.userCart,
  });

  factory Cart.fromMap(Map<String, dynamic> json) {
    return Cart(
      id: json['_id'],
      userId: json['userId'],
      userCart: (json['userCart'] as List)
          .map((item) => UserCartItem.fromMap(item))
          .toList(),
    );
  }
}