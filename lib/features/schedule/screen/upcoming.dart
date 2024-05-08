import 'package:flutter/material.dart';
import 'package:medihub/features/schedule/models/appointment.dart';
import 'package:medihub/features/schedule/services/scheduleServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Updated API response class

class UpcomingAppointments extends StatefulWidget {
  const UpcomingAppointments({Key? key}) : super(key: key);

  @override
  State<UpcomingAppointments> createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {

   List<Appointment>? appointments;
    String? authToken;
    final ScheduleServices scheduleServices = ScheduleServices();

    void fetchToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    authToken = sharedPreferences.getString('x-auth-token');
    if (authToken != null) {
      fetchAppointments(authToken!);
    }
    // Get the token from shared preferences
  }

  fetchAppointments (String authToken)async{

    appointments = await scheduleServices.getAppointments(authToken);

    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    fetchToken();
  }

  @override
  Widget build(BuildContext context) {
    // List<Appointment> appointments = [
    //   Appointment(
    //     doctorName: 'Dr. Marcus Horizon',
    //     doctorSpecialization: 'Cardiologist',
    //     appointmentDate: '26/06/2022',
    //     appointmentTime: '10:30 AM',
    //     imageUrl: 'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
    //     isConfirmed: true,
    //   ),
    //   Appointment(
    //     doctorName: 'Dr. Jane Doe',
    //     doctorSpecialization: 'Neurologist',
    //     appointmentDate: '30/06/2022',
    //     appointmentTime: '09:00 AM',
    //     imageUrl: 'https://img.freepik.com/free-photo/portrait-handsome-young-doctor-looking-camera-smiling_176420-6220.jpg',
    //     isConfirmed: false,
    //   ),
    //   Appointment(
    //     doctorName: 'Dr. Alex Smith',
    //     doctorSpecialization: 'Dermatologist',
    //     appointmentDate: '02/07/2022',
    //     appointmentTime: '11:45 AM',
    //     imageUrl: 'https://img.freepik.com/free-photo/doctor-with-stethoscope-around-neck_1154-19869.jpg',
    //     isConfirmed: true,
    //   ),
    // ]

    


    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Appointments'),
      ),
      body: appointments == null ? Center(child: CircularProgressIndicator(),) : ListView.builder(
        itemCount: appointments!.length,
        itemBuilder: (context, index) {
          return buildAppointmentItem(appointments![index]);
        },
      ),
    );
  }

  Widget buildAppointmentItem(Appointment appointment) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.doctorName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    appointment.doctorCategory,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(width: 110),
              CircleAvatar(
                backgroundImage: NetworkImage(appointment.doctorImage),
                radius: 30,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.calendar_month),
              Text(
                ' ${appointment.date}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 20),
              Icon(Icons.schedule),
              Row(
                children: [
                  Text(
                    ' ${appointment.timeslot}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 20),
                  Icon(Icons.circle,
                      color: appointment.isConfirmed
                          ? Colors.green
                          : Colors.grey,
                      size: 10),
                  SizedBox(width: 5),
                  Text(
                    appointment.isConfirmed ? 'Confirmed' : 'Not Confirmed',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: appointment.isConfirmed
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle reschedule button press
                },
                child: Text(
                  'Reschedule',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  // Handle cancel button press
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
