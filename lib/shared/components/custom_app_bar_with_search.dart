import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'custom_search_bar.dart';

class CustomAppBarWithSearch extends StatelessWidget with PreferredSizeWidget {
   CustomAppBarWithSearch({
    Key key,
    this.title,
    this.colorAB=Colors.white,
    this.withFilter = false,this.colorIcon=Colors.black
  }) : super(key: key);

  final String title;
  Color colorAB;
  final bool withFilter;
   Color colorIcon;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
      child: AppBar(
        elevation: 0,
        backgroundColor: HexaColor.fromHexa("#2d2d37"),//colorAB,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal,color: colorIcon),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color:colorIcon,// Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                withFilter
                    ? Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color:  colorIcon,//Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          CupertinoIcons.line_horizontal_3_decrease,
                          color:colorIcon// Colors.white,
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  width: withFilter ? 10 : 0,
                ),
                Expanded(child: CustomSearchBar(colorIcon)),
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
