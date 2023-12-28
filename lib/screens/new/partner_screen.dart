import 'package:flutter/material.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safsofa/screens/new/Commitments_Screen.dart';
import 'package:safsofa/screens/new/expenses_screen.dart';
import 'package:safsofa/screens/new/mail_screen/presentation/screen/main_mail_screen/main_mail_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../network/local/cache_helper.dart';
import '../../shared/constants.dart';
import 'InventoryScreen.dart';
import 'PartnerOrdersScreen.dart';
import 'assignment_screen.dart';
import 'financial_reports_screen/financial_reports_screen.dart';

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
              if(CacheHelper.getData('type')==0)
              Row(
                children: [
                  itemPartner(title: 'reportsRequests'.tr(),image: 'assets/images/reportsRequests.png',onTap: (){
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
                  itemPartner(title: 'commitments'.tr(),image: 'assets/images/commitments.png',onTap: (){
                    navigateTo(context, CommitmentsScreen());
                  }),
                  SizedBox(width: 10.w,),
                  itemPartner(title: 'inventory'.tr(),image: 'assets/images/inventory.png',onTap: (){
                    navigateTo(context, InventoryScreen());

                  }),
                ],
              ),
              Row(
                children: [

                  itemPartner(title: 'sales'.tr(),image: 'assets/images/financialReports.png',onTap: (){
                    navigateTo(context, FinancialReportsScreen());

                  }),
                  if(CacheHelper.getData('type')==0)
                  SizedBox(width: 10.w,),
                  if(CacheHelper.getData('type')==0)
                  itemPartner(title: 'expenses'.tr(),image: 'assets/images/expenses.png',onTap: (){
                    navigateTo(context, ExpensesScreen());

                  }),
                  if(CacheHelper.getData('type')==0)
                  SizedBox(width: 10.w,),
                  if(CacheHelper.getData('type')==0)
                  itemPartner(title: 'assignment'.tr(),image: 'assets/images/assignment.png',onTap: (){
                    navigateTo(context, AssignmentScreen());

                  }),

                ],
              ),
              if(CacheHelper.getData('type')==0)
              Row(
                children: [
                  itemPartner(title: "mailBox".tr(),image: 'assets/images/financialReports.png',onTap: (){
                    navigateTo(context, MainMailScreen());

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

Widget itemPartner({void Function()? onTap,required String title,required String image}){
  return Column(
    children: [
      InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10.r),
          height: 80.h,
          width: 80.w,
          decoration: BoxDecoration(
            color: kLightGoldColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child:Image.asset(image),
        ),
      ),
      SizedBox(height: 10.h,),
      SizedBox(height:50,width:100.w,child: Text(title,style: TextStyle(
        fontSize: 12.sp
      ),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)),
    ],
  );
  ;
}
