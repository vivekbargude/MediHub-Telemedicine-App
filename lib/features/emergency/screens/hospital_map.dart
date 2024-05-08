import 'package:flutter/material.dart';
import 'package:medihub/features/emergency/services/emergency_services.dart';

class HospitalMap extends StatelessWidget {
  static const String routeName = 'map';
  final List<Hospital>? hospitals;
  const HospitalMap({super.key,required this.hospitals});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}