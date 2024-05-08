import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:medihub/features/emergency/services/emergency_services.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;
import 'package:location/location.dart' as location;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatefulWidget {
  static const String routeName = '/emergency';
  EmergencyScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {

  final EmergencyServices  emergencyServices = EmergencyServices();
  List<Hospital>? fetchList;
  bool isMessageSend = false;
  String? authtoken;


  @override
  void initState() {
    super.initState();
    fetchHospitals();
  }

  void fetchHospitals() async{

   await emergencyServices.getCurrentLocation();
  final locationData = emergencyServices.getCurrentLocationData();

  if (locationData != null) {
    double? latitude = locationData.latitude;
    double? longitude = locationData.longitude;

    final userlocation = LatLng(latitude!, longitude!);

    print('$latitude $longitude');

    try {
      List<Hospital>? hospitals = await emergencyServices.fetchNearbyHospitals(userlocation);
      if (hospitals != null) {
        setState(() {
          fetchList = hospitals;
        });
      } else {
        print('No hospitals found.');
      }
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
       authtoken = sharedPreferences.getString('x-auth-token');
      final address = await emergencyServices.getAddress(latitude, longitude);
      String messageBody = 'Emergency at: $address';

      isMessageSend = await emergencyServices.sendMessage(authtoken,'+919579483461',messageBody);
      if(isMessageSend)
      print("Message send successfully");
      print(address);
      print('Emergency at: $address');
    } catch (e) {
      print("Fetch hospital error $e");
    }

  } else {
    print('Failed to get current location');
  }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Nearby Hospitals"),
      ),
      body: fetchList == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: fetchList!.length,
              itemBuilder: (context, index) {
                final hospital = fetchList![index];
                return Card(
                  elevation: 4, // Adjust elevation as needed
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(Icons.local_hospital_rounded), // Hospital icon
                    title: Text(
                      hospital.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                        'Location: ${hospital.location.latitude}, ${hospital.location.longitude}'),
                    onTap: () {
                      launch(
                          'https://www.openstreetmap.org/?mlat=${hospital.location.latitude}&mlon=${hospital.location.longitude}');
                    },
                  ),
                );
              },
            ),
    );
  }
}
