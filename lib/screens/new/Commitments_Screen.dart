 import 'package:flutter/material.dart%20';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safsofa/screens/new/committments_details_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
 import '../../shared/constants.dart';
 import 'package:easy_localization/easy_localization.dart';

class CommitmentsScreen extends StatelessWidget {
  const CommitmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'commitments'.tr()),
      body: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 20.h
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CommitmentsDetailsScreen(type:1,title: "capitalCosts".tr(),)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: kLightGoldColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child:SvgPicture.asset("assets/images/Group 345.svg"),
                  ),
                ),
                SizedBox(height: 10.h,),
                Text("capitalCosts".tr()),
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CommitmentsDetailsScreen(type:2,title: "operationalCosts".tr(),)));

                  },
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: kLightGoldColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child:SvgPicture.asset("assets/images/Group 345.svg"),
                  ),
                ),
                SizedBox(height: 10.h,),
                Text("operationalCosts".tr()),
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CommitmentsDetailsScreen(type:3,title:"foundational".tr() ,)));

                  },
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: kLightGoldColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child:SvgPicture.asset("assets/images/Group 345.svg"),
                  ),
                ),
                SizedBox(height: 10.h,),
                Text("foundational".tr()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
