import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medihub/features/news/backend/functions.dart';
import 'package:medihub/features/news/utils/colors.dart';
import 'package:medihub/features/news/utils/constants.dart';

class VertHome extends StatefulWidget {
  const VertHome({Key? key}) : super(key: key);

  static const String routeName = "vertHome";

  @override
  _VertHomeState createState() => _VertHomeState();
}

class _VertHomeState extends State<VertHome> {
  late Future<List> news;

  @override
  void initState() {
    super.initState();
    news = fetchnews();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          // SearchBar(),
          Expanded(
            child: Container(
              width: w,
              child: FutureBuilder<List>(
                future: fetchnews(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitFadingCircle(
                        color: AppColors.white,
                        size: 50.0,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text("No news available."),
                    );
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(snapshot.data!.length, (index) {
                          return Container(
                            width: w * 0.4, // Adjust width according to your need
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image
                                Container(
                                  height: 150, // Adjust height according to your need
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        snapshot.data![index]['urlToImage'] != null
                                            ? snapshot.data![index]['urlToImage']
                                            : Constants.imageurl,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8), // Add spacing between image and title
                                // Title
                                Text(
                                  snapshot.data![index]['title'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 3, // Limit to 3 lines
                                  overflow: TextOverflow.ellipsis, // Add ellipsis if overflow
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
