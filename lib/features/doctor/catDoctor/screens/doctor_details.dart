// import 'package:flutter/material.dart';
// import 'package:medihub/features/doctor/services/doctorService.dart';
// import 'package:medihub/models/doctor.dart';


// class DoctorDetails extends StatefulWidget {
//   static const routeName = 'doctor-details';
//   final String doctId;
//   const DoctorDetails({super.key,required this.doctId});

//   @override
//   State<DoctorDetails> createState() => _DoctorDetailsState();
// }

// class _DoctorDetailsState extends State<DoctorDetails> {

//   Doctor? doctor;
//   final DoctorService doctorService = DoctorService();

//   @override
//   void initState() {
//     super.initState();
//     fetchDoctorDetails(widget.doctId);
//   }

//   fetchDoctorDetails(String doctId)async{

//     doctor = await doctorService.getDoctorDetails(doctId: doctId, context: context);

//     setState(() {
      
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Center(child: Text('Doctor Details'))),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child:doctor != null
//           ? Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Image.network(doctor!.doctImage ?? ''), // Use null check for image URL
//                 SizedBox(height: 5),
//                 Text(doctor!.doctName ?? ''), // Use null check for name
//                 SizedBox(height: 5),
//                 Text(doctor!.doctCategory ?? ''), // Use null check for category
//                 SizedBox(height: 5),
//                 Text(doctor!.doctDesc ?? ''), // Use null check for description
//               ],
//             )
//           : Center(
//               child: CircularProgressIndicator(),
//             ),
//       ),
//     );
//   }
// }