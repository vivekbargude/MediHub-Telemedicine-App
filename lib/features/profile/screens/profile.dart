import 'package:flutter/material.dart';
import 'package:medihub/constants/colors.dart';

class ProfileTwoPage extends StatelessWidget {
  ProfileTwoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [shadowColor, bgColor]),
            ),
          ),
          ListView.builder(
            itemCount: 7,
            itemBuilder: _mainListBuilder,
          ),
        ],
      ),
    );
  }

  Widget _mainListBuilder(BuildContext context, int index) {
    if (index == 0) return _buildHeader(context);
    if (index == 1) return _buildBody(context);
    return _buildListItem();
  }

  Widget _buildListItem() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      height: 240.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                top: 40.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    "Test User",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text("Health Enthusiat"),
                  const SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: const Text(
                              "215bpm",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Heart Rate".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: const Text(
                              "756cal",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Calories".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: const Text(
                              "120lbs",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Weight".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12.0)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: const CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildMenuItem(context, "My Saved", Icons.save),
        _buildMenuItem(context, "Appointment", Icons.event),
        _buildMenuItem(context, "Payment Method", Icons.payment),
        _buildMenuItem(context, "FAQs", Icons.question_answer),
        _buildMenuItem(context, "Logout", Icons.logout),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (title == "Logout") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Logout"),
              content: Text("Are you sure you want to logout?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    // Implement logout logic
                    Navigator.pop(context);
                  },
                  child: Text("Logout"),
                ),
              ],
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon),
                SizedBox(width: 16.0),
                Text(
                  title,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
