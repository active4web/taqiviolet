 import 'package:flutter/material.dart%20';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
 import '../../shared/constants.dart';

class CommitmentsScreen extends StatelessWidget {
  const CommitmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          // title: Text("${title}"),
          backgroundColor: Color(0xff393846),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Color(0xff393846),
              statusBarIconBrightness: Brightness.light),

          ///Color(),// Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
              color: kLightGoldColor,
              fontFamily: 'Tajawal',
              fontSize: 17),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(60),
              bottomLeft: Radius.circular(60),
            ),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "الالتزامات",
                style: TextStyle(
                    color: kLightGoldColor, fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),


            ],
          ),
          iconTheme: IconThemeData(color: kLightGoldColor),
          actions: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10),
              child: Image(
                image:
                AssetImage('assets/images/logoheader.png'),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: kLightGoldColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:SvgPicture.asset("assets/images/Group 345.svg"),
                ),
                SizedBox(height: 10,),
                Text("تكاليف الرأس مالية"),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: kLightGoldColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:SvgPicture.asset("assets/images/Group 345.svg"),
                ),
                SizedBox(height: 10,),
                Text("تكاليف الرأس مالية"),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: kLightGoldColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:SvgPicture.asset("assets/images/Group 345.svg"),
                ),
                SizedBox(height: 10,),
                Text("تكاليف الرأس مالية"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
