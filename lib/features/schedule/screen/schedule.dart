import 'package:flutter/material.dart';
import 'package:medihub/constants/colors.dart';
import 'package:medihub/features/schedule/screen/upcoming.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none_outlined),
            onPressed: () {
              // Add your notification icon action here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                text: 'Upcoming',
              ),
              Tab(
                text: 'Completed',
              ),
              Tab(
                text: 'Canceled',
              ),
            ],
            indicatorColor: bgColor, // Change the indicator color here
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                UpcomingAppointments(),
                Center(child: Text('Completed')),
                Center(child: Text('Canceled')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
