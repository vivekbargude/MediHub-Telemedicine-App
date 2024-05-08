import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medihub/features/doctor/BookDoc/BookDoc.dart';
import 'package:medihub/features/doctor/models/freeTimeSlots.dart';
import 'package:medihub/features/doctor/services/doctorService.dart';
import 'package:medihub/models/doctor.dart';

class DoctorDetail extends StatefulWidget {
  static const String routeName = '/doctor-detail';
  final String doctId;
  const DoctorDetail({Key? key,required this.doctId}) : super(key: key);

  @override
  State<DoctorDetail> createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetail> {
  late DateTime _selectedDate;

  Doctor? doctor;
  final DoctorService doctorService = DoctorService();
  int? selectedTimeSlotIndex;
  List<FreeTimeSlot>? timeslots;
  String? formattedDate;
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    fetchDoctorDetails(widget.doctId);
    fetchFreeTimeSlots(widget.doctId);
  }

  fetchDoctorDetails(String doctId) async {
    doctor = await doctorService.getDoctorDetails(doctId: doctId, context: context);
    setState(() {});
  }

  fetchFreeTimeSlots(String doctId) async {
    timeslots = await doctorService.fetchFreeTimeSlots(doctId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    List<DateTime> dates = List.generate(7, (index) {
      return DateTime.now().add(Duration(days: index));
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Detail'),
        centerTitle: true,
      ),
      body: doctor == null ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 130,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        doctor!.doctImage!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor!.doctName!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(doctor!.doctCategory!),
                          const Text('4.5'),
                          const Text('800m'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Day and Date',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return GestureDetector(
// Inside the GestureDetector onTap callback
                          onTap: () {
                            setState(() {
                              _selectedDate = DateTime(dates[index].year, dates[index].month, dates[index].day);
                               formattedDate = DateFormat('dd-MM-yyyy').format(_selectedDate);
                              print(formattedDate);
                            });
                          },

                      child: Card(
                        color: _selectedDate.day == dates[index].day ? Colors.blue : null,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                weekdays[dates[index].weekday - 1],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _selectedDate.day == dates[index].day ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                DateFormat('dd-MM-yyyy').format(dates[index]),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _selectedDate.day == dates[index].day ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              const SizedBox(height: 16),
              const Text(
                'Select Time Slot',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              timeslots == null
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2,
                ),
                itemCount: timeslots!.length,
                itemBuilder: (context, index) {
                  final timeSlot = timeslots![index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTimeSlotIndex = index;
                      });
                    },
                    child: Card(
                      color: selectedTimeSlotIndex == index ? Colors.blue : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Text(
                            '${timeSlot.startTime} - ${timeSlot.endTime}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              // Book Appointment button
              TextButton(
                onPressed: () {
                                if (selectedTimeSlotIndex != null && _selectedDate != null) {
                                  FreeTimeSlot selectedTimeSlot = timeslots![selectedTimeSlotIndex!];
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookingPage(
                                        doctId: widget.doctId,
                                        doctName: doctor!.doctName!,
                                        doctCategory: doctor!.doctCategory!,
                                        doctImage : doctor!.doctImage!,
                                        date: formattedDate.toString(),
                                        timeslotId: selectedTimeSlot.id,
                                        startTime: selectedTimeSlot.startTime,
                                      ),
                                    ),
                                  );
                                } else if (_selectedDate == null) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Please select a date.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Please select a time slot.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },

                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Book Appointment',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
