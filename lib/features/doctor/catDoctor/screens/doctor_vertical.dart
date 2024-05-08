import 'package:flutter/material.dart';
import 'package:medihub/features/doctor/DocDetail/DocDetailScreen.dart';
import 'package:medihub/models/doctor.dart';
import 'package:medihub/features/doctor/services/doctorService.dart';

class DoctorVertical extends StatefulWidget {
  final String doctCategory;
  const DoctorVertical({Key? key,required this.doctCategory}) : super(key: key);

  static const routeName = 'category';

  @override
  State<DoctorVertical> createState() => _DoctorVerticalState();
}

class _DoctorVerticalState extends State<DoctorVertical> {
   
   List<Doctor>? doctorList;
   final DoctorService doctorService = DoctorService();

  @override
  void initState() {
    super.initState();
    fetchDoctorsByCategory(widget.doctCategory);
  }

  fetchDoctorsByCategory(String doctCategory)async{
    print("hey");
    doctorList = await doctorService.fetchDoctorsByCategory(doctCategory);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text("Top Doctor"))),
       body: doctorList == null ? Center(child: CircularProgressIndicator()) : 
           ListView.builder(
      itemCount: doctorList!.length,
      itemBuilder: (context, index) {
        final doctor = doctorList![index];
        return GestureDetector(
          onTap: (){
            String doctId = doctor.doctId!;
            Navigator.pushNamed(context, DoctorDetail.routeName,arguments:  doctId );
          },
          child: Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            child: ListTile(
            
              leading: Image.network(doctor.doctImage!),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor.doctName!),
                  SizedBox(height: 4),
                  Text(doctor.doctCategory!),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Text("4.5"), // Assuming doctRating is the property holding the rating
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
    );
  }
}
