import 'package:flutter/material.dart';
import 'package:medihub/features/news/utils/colors.dart';
import 'package:medihub/features/news/utils/text.dart';

class appbar extends StatelessWidget implements PreferredSizeWidget {
  appbar({Key? key})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  final Size preferredSize;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        ],
      backgroundColor: AppColors.purple,
      elevation: 0,
      title: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              modifiedText(text: 'NewsApp', size: 30, color: AppColors.lightwhite)
            ],
          )),
      centerTitle: true,
    );
  }
}
