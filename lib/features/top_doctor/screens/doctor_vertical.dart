import 'package:flutter/material.dart';
import 'package:medihub/features/doctor/DocDetail/DocDetailScreen.dart';
import 'package:medihub/features/top_doctor/services/doctor_service_all.dart';
import 'package:medihub/models/doctor.dart';

class DoctorVerticalMain extends StatefulWidget {
  const DoctorVerticalMain({Key? key}) : super(key: key);

  @override
  State<DoctorVerticalMain> createState() => _DoctorVerticalState();
}

class _DoctorVerticalState extends State<DoctorVerticalMain> {
  List<Doctor>? doctorList;
  final DoctorServiceAll doctorServiceAll = DoctorServiceAll();

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }


  _fetchDoctors() async {

    doctorList = await doctorServiceAll.fetchDoctors();
    setState(() {   
    });

  }

   @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 15),
        itemCount: doctorList?.length ?? 0,
        itemBuilder: (context, index) {
          final product = doctorList![index];
          return GestureDetector(
            onTap: () {
              String doctId = product!.doctId!;
              Navigator.pushNamed(context, DoctorDetail.routeName , arguments: doctId);
              
            },
            child: Container(
              width: 150,
              height: 170, // Adjust the width of each item
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 0.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.network(
                        product.doctImage!,
                        // fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    product.doctName!,
                    maxLines: 1,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '4.5',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


