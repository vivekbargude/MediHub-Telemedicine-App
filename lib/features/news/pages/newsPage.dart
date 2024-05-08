import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medihub/features/news/components/components.dart';
import 'package:medihub/features/news/utils/text.dart';
import 'package:url_launcher/link.dart';

class NewsPage extends StatelessWidget {
  final String title, description, imageurl, url;

  NewsPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imageurl,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BottomSheetImage(imageurl: imageurl, title: title),
            Padding(
              padding: EdgeInsets.all(10),
              child: modifiedText(
                text: description,
                size: 16,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Link(
                uri: Uri.parse(url),
                builder: (context, followLink) {
                  return GestureDetector(
                    onTap: followLink,
                    child: Text(
                      'Read Full Article',
                      style: GoogleFonts.lato(
                        color: Colors.blue.shade400,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
