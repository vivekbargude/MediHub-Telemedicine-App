import 'package:flutter/material.dart';

class AmbulanceMap extends StatefulWidget {
  static const routeName = "/ambulance";
  const AmbulanceMap({super.key});

  @override
  State<AmbulanceMap> createState() => _AmbulanceMapState();
}

class _AmbulanceMapState extends State<AmbulanceMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ambulance")),
      body : Center(child: Text("Feature coming soon"),)
    );
  }
}