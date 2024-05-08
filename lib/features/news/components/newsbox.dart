import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import the SpinKit library
import 'package:medihub/constants/colors.dart';
import 'package:medihub/features/news/pages/newsPage.dart';
import 'package:medihub/features/news/utils/colors.dart';
import 'package:medihub/features/news/utils/text.dart';

import 'bottomsheet.dart';
import 'components.dart';

class NewsBox extends StatelessWidget {
  final String imageurl, title, time, description, url, content;

  const NewsBox({
    Key? key,
    required this.imageurl,
    required this.title,
    required this.time,
    required this.description,
    required this.content,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        ColoredBox(color: shadowColor),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsPage(
                  title: title,
                  description: description,
                  imageurl: imageurl,
                  url: url,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: shadowColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(left: 5, right: 5, top: 5),
              width: w,
              // color: shadowColor,
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: imageurl,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow,
                      ),
                    ),
                    placeholder: (context, url) => SpinKitFadingCircle(
                      color: AppColors.white,
                      size: 30.0,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        modifiedText(
                          color: AppColors.black,
                          size: 16,
                          text: title,
                        ),
                        SizedBox(height: 5),
                        modifiedText(
                          color: AppColors.black,
                          size: 12,
                          text: time,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        DividerWidget()
      ],
    );
  }
}
