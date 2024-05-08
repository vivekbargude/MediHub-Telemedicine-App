// import 'package:flutter/material.dart';
// import 'package:medihub/models/doctor.dart';
// import '../services/doctor_service.dart';

// class HorizontalDoctorList extends StatefulWidget {
//   const HorizontalDoctorList({Key? key}) : super(key: key);

//   @override
//   _HorizontalDoctorListState createState() => _HorizontalDoctorListState();
// }

// class _HorizontalDoctorListState extends State<HorizontalDoctorList> {
//   late Future<List<Doctor>> _doctorsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _doctorsFuture = DoctorService.fetchDoctors();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//     //   height: 120,
//     //   child: FutureBuilder<List<Doctor>>(
//     //     future: _doctorsFuture,
//     //     builder: (context, snapshot) {
//     //       if (snapshot.connectionState == ConnectionState.waiting) {
//     //         return Center(child: CircularProgressIndicator());
//     //       } else if (snapshot.hasError) {
//     //         return Center(child: Text('Error: ${snapshot.error}'));
//     //       } else {
//     //         return ListView.builder(
//     //           scrollDirection: Axis.horizontal,
//     //           itemCount: snapshot.data!.length,
//     //           itemBuilder: (context, index) {
//     //             final doctor = snapshot.data![index];
//     //             return Padding(
//     //               padding: const EdgeInsets.all(8.0),
//     //               child: Column(
//     //                 children: [
//     //                   CircleAvatar(
//     //                     radius: 30,
//     //                     backgroundImage: NetworkImage(doctor.imgUrl),
//     //                   ),
//     //                   SizedBox(height: 4),
//     //                   Text(
//     //                     doctor.name,
//     //                     style: TextStyle(fontSize: 12),
//     //                   ),
//     //                 ],
//     //               ),
//     //             );
//     //           },
//     //         );
//     //       }
//     //     },
//     //   ),
//     // );
//     );
//   }
// }

