import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medihub/features/news/components/components.dart';
import 'package:medihub/features/news/utils/text.dart';
import 'package:url_launcher/link.dart';

void showMyBottomSheet(
    BuildContext context,
    String title,
    String description,
    String imageurl,
    String url,
    ) {
  showBottomSheet(
    backgroundColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    elevation: 20,
    context: context,
    builder: (context) {
      return MyBottomSheetLayout(
        url: url,
        imageurl: imageurl,
        title: title,
        description: description,
      );
    },
  );
}

class MyBottomSheetLayout extends StatelessWidget {
  final String title, description, imageurl, url;

  const MyBottomSheetLayout({
    Key? key,
    required this.title,
    required this.description,
    required this.imageurl,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BottomSheetImage(imageurl: imageurl, title: title),
          Container(
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
    );
  }
}
