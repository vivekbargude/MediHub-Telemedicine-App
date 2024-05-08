import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medihub/features/news/backend/functions.dart';
import 'package:medihub/features/news/backend/functions.dart';
import 'package:medihub/features/news/components/appbar.dart';
import 'package:medihub/features/news/components/newsbox.dart';
import 'package:medihub/features/news/components/searchbar.dart';
import 'package:medihub/features/news/utils/colors.dart';
import 'package:medihub/features/news/utils/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

   static const String routeName = "newsHome";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return NewsBox(
                          url: snapshot.data![index]['url'],
                          imageurl: snapshot.data![index]['urlToImage'] != null
                              ? snapshot.data![index]['urlToImage']
                              : Constants.imageurl,
                          title: snapshot.data![index]['title'],
                          time: snapshot.data![index]['publishedAt'],
                          description:
                          snapshot.data![index]['description'].toString(),
                          content: '',
                        );
                      },
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
