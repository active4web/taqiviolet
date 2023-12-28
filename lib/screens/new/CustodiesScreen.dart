import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/constants.dart';

class CustodiesScreen extends StatelessWidget {
  const CustodiesScreen({Key? key}) : super(key: key);

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
                "العهد",
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
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "رقم العهدة",
                      style: TextStyle(
                          fontSize: 10
                      ),
                    ),
                    Text(
                      "التفاصيل",
                      style: TextStyle(
                          fontSize: 10
                      ),
                    ),
                    Text(
                      "اجمالى العهدة",
                      style: TextStyle(
                          fontSize: 10
                      ),
                    ),
                    Text(
                      "تاريخ الشراء",
                      style: TextStyle(
                          fontSize: 10
                      ),
                    ),
                    Text(
                      "الصورة",
                      style: TextStyle(
                          fontSize: 10
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),

              Table(
                columnWidths: {
                  0: FlexColumnWidth(8.w),
                  1: FlexColumnWidth(55.w),
                  2: FlexColumnWidth(22.w),
                  3: FlexColumnWidth(22.w),
                },
                children: List.generate(10,
                  // cubit.searchController.text == ''
                  //     ? cubit.projectsData!.data!.length
                  //     : cubit.searchData.length,
                      (index) =>
                      TableRow(
                        decoration: BoxDecoration(
                            color: index % 2 == 0
                                ?  Colors.grey.withOpacity(0.5)
                                :  Colors.white),
                        children: [
                          TableRowInkWell(
                            onTap: () {
                              print(
                                  "5");
                              print("bahr"*10);

                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  child: Row(
                                    textBaseline: TextBaseline.alphabetic,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "1"*5,
                                        style: TextStyle(
                                            fontSize: 10
                                        ),
                                      ),
                                      Text(
                                        "1"*5,
                                        style: TextStyle(
                                            fontSize: 10
                                        ),
                                      ),
                                      Text(
                                        "1"*5,
                                        style: TextStyle(
                                            fontSize: 10
                                        ),
                                      ),
                                      Text(
                                        "1"*5,
                                        style: TextStyle(
                                            fontSize: 10
                                        ),
                                      ),
                                      Image.asset("assets/images/ec.png",
                                        height: 30,
                                        width: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
