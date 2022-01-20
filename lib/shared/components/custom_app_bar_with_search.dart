import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'custom_search_bar.dart';

class CustomAppBarWithSearch extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBarWithSearch({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: kDarkGoldColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    CupertinoIcons.line_horizontal_3_decrease,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: CustomSearchBar()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(140);
}
