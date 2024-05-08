import 'package:medihub/features/pharmacy/services/productModel.dart';
import 'dart:convert';

class UserCartItem {
  String id;
  Pharmacy pharmacy;
  int quantity;

  UserCartItem({
    required this.id,
    required this.pharmacy,
    required this.quantity,
  });

  factory UserCartItem.fromMap(Map<String, dynamic> json) {
    return UserCartItem(
      id: json['_id'],
      pharmacy: Pharmacy.fromMap(json['pharmacy']),
      quantity: json['quantity'],
    );
  }
}