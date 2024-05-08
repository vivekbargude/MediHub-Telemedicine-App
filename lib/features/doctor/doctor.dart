import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medihub/utils/customContainer.dart';
import 'package:medihub/utils/custom_doctor_container.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({Key? key}) : super(key: key);

  static const String routeName = "doctor";

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

void onCustomContainerTap(String text) {
    // Handle the tap event here, you can navigate or perform other actions
    print("Tapped CustomContainer with text: $text");
    // You can call your backend API here and pass the text as needed
  }



class _DoctorScreenState extends State<DoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Doctor'),
        centerTitle: true, // Center the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 5, left: 10, right: 10),
              child: SearchBar(
                leading: Icon(Icons.search),
                hintText: "Search doctor, drug, article...",
              ),
            ),
            GestureDetector(
              onTap: (){
                
              },
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15, left: 10, right: 5),
                    child: Row(
                      children: [
                        CustomDoctorContainer(
                          text: 'General',
                          imagePath: 'assets/Doctor.png',
                          // routeName: 'General',
                        ),
                        CustomDoctorContainer(
                          text: 'Lungs',
                          imagePath: 'assets/Pharmacy.png',
                          // routeName: 'pharmacy',
                        ),
                        CustomDoctorContainer(
                          text: 'Dentist',
                          imagePath: 'assets/Hospital.png',
                          // routeName:
                          //     '/hospital', // Replace '/hospital' with the actual named route
                        ),
                        CustomDoctorContainer(
                          text: 'Psychiatrist',
                          imagePath: 'assets/Ambulance.png',
                          // routeName:
                          //     '/ambulance', // Replace '/ambulance' with the actual named route
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Row(
              children: [
                 Padding(
                  padding: EdgeInsets.only(top: 15, left: 10, right: 5),
                  child: Row(
                    children: [
                      CustomDoctorContainer(
                        text: 'Covid-19',
                        imagePath: 'assets/Doctor.png',
                        // routeName: 'doctor',
                      ),
                      CustomDoctorContainer(
                        text: 'Surgeon',
                        imagePath: 'assets/Pharmacy.png',
                        // routeName: 'pharmacy',
                      ),
                      CustomDoctorContainer(
                        text: 'CardioLogist',
                        imagePath: 'assets/Hospital.png',
                        // routeName:
                        //     '/hospital', // Replace '/hospital' with the actual named route
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
