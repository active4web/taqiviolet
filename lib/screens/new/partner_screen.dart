import 'package:flutter/material.dart%20';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safsofa/screens/new/Commitments_Screen.dart';
import 'package:safsofa/screens/new/expenses_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../shared/constants.dart';
import 'InventoryScreen.dart';
import 'PartnerOrdersScreen.dart';
import 'assignment_screen.dart';
import 'financial_reports_screen.dart';

class PartnerScreen extends StatelessWidget {
  const PartnerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'reports'.tr(),
      ),
      body: Padding(
        padding:  EdgeInsets.all(20.0.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.h,),
              Row(
                children: [
                  itemPartner(title: 'reportsRequests'.tr(),onTap: (){
                    navigateTo(context, PartnerOrdersScreen());
                  }),
                  SizedBox(width: 10.w,),
                  // Expanded(
                  //     child: InkWell(
                  //       onTap: (){
                  //         showDialog(
                  //           context: context,
                  //           builder: (ctx) => AlertDialog(
                  //             title: const Text("رأس المال"),
                  //             content: Column(
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: [
                  //                 Row(
                  //                   children: [
                  //                     Text('الربح:',style: TextStyle(
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 20.sp
                  //                     ),),
                  //                     SizedBox(width: 10.w,),
                  //                     Text('sr 32432',style: TextStyle(
                  //                       color: kCustomBlack,
                  //                       fontSize: 20.sp
                  //                     ),)
                  //                   ],
                  //                 ),
                  //                 Row(
                  //                   children: [
                  //                     Text('المتبقي:',style: TextStyle(
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 20.sp
                  //                     ),),
                  //                     SizedBox(width: 10.w,),
                  //                     Text('sr 32432',style: TextStyle(
                  //                       color: kCustomBlack,
                  //                       fontSize: 20.sp
                  //                     ),)
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //             actions: <Widget>[
                  //               TextButton(
                  //                 onPressed: () {
                  //                   Navigator.of(ctx).pop();
                  //                 },
                  //                 child: Container(
                  //                   color:kDarkGoldColor,
                  //                   padding: const EdgeInsets.all(14),
                  //                   child: const Text("okay"),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         );
                  //       },
                  //       child: Container(
                  //         child:  Center(
                  //           child: Text(
                  //             "رأس المال",
                  //             style: TextStyle(
                  //               fontSize: 23,
                  //               color: Colors.black87,
                  //             ),
                  //           ),
                  //         ),
                  //         height: 120,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: Colors.white,
                  //           border: Border.all(
                  //             color: Colors.grey.withOpacity(0.5),
                  //           ),
                  //         ),
                  //       ),
                  //     )),
                  itemPartner(title: 'commitments'.tr(),onTap: (){
                    navigateTo(context, CommitmentsScreen());
                  }),
                  SizedBox(width: 10.w,),
                  itemPartner(title: 'inventory'.tr(),onTap: (){
                    navigateTo(context, InventoryScreen());

                  }),
                ],
              ),
              Row(
                children: [
                  itemPartner(title: 'financialReports'.tr(),onTap: (){
                    navigateTo(context, FinancialReportsScreen());

                  }),
                  SizedBox(width: 10.w,),

                  itemPartner(title: 'expenses'.tr(),onTap: (){
                    navigateTo(context, ExpensesScreen());

                  }),
                  SizedBox(width: 10.w,),
                  itemPartner(title: 'assignment'.tr(),onTap: (){
                    navigateTo(context, AssignmentScreen());

                  }),

                ],
              ),


              SizedBox(height: 10.h,),

            ],
          ),
        ),
      ),
    );
  }
}

Widget itemPartner({void Function()? onTap,required String title}){
  return Column(
    children: [
      InkWell(
        onTap: onTap,
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
      SizedBox(height:50,width:100.w,child: Text(title,style: TextStyle(),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)),
    ],
  );
  ;
}
