import 'package:flutter/material.dart%20';
import 'package:flutter/services.dart';

import '../../shared/constants.dart';

class CapitalScreen extends StatelessWidget {
  const CapitalScreen({Key? key}) : super(key: key);

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
                "المتبقى",
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
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
                child: InkWell(
                  onTap: (){

                  },
                  child: Container(
                    child:  Center(
                      child: Text(
                        "المصروف : 500",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                )),
            SizedBox(width: 10,),
            Expanded(
                child: InkWell(
                  onTap: (){

                  },
                  child: Container(
                    child:  Center(
                      child: Text(
                        "الربح : 200",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
