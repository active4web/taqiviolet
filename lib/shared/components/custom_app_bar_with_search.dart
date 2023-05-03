import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import 'custom_search_bar.dart';

class CustomAppBarWithSearch extends StatelessWidget with PreferredSizeWidget {
  CustomAppBarWithSearch(
      {
      this.title,
      this.colorAB = Colors.white,
      this.withFilter = false,
      this.colorIcon = Colors.white,
       this.controller,
        this.function,
       this.onChange})
       ;

  final String? title;
  Color? colorAB;
  final bool withFilter;
  final Function? function;
  Color colorIcon;
  TextEditingController? controller;
  void Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
      child: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff393846), //
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xff393846),
            statusBarIconBrightness: Brightness.light
        ) ,
// colorAB,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(60)),
        ),
        title: Text(
          "${title}",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.normal, color: colorIcon),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: colorIcon, // Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image(
              image: AssetImage('assets/images/logoheader.png'),
            ),
          )
        ],
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                withFilter
                    ? InkWell(
                  onTap: (){
                    function!();
                  },
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: colorIcon, //Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(CupertinoIcons.line_horizontal_3_decrease,
                              color: Colors.black // Colors.white,
                              ),
                        ),
                    )
                    : SizedBox(),
                SizedBox(
                  width: withFilter ? 10 : 0,
                ),
                Expanded(
                    child: CustomSearchBar(
                  border: colorIcon,
                  controller: controller,
                  onChange: onChange,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(110);
}
