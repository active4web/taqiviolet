import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../shared/constants.dart';
import '../../../../../shared/defaults.dart';
import '../../../CustodiesScreen.dart';
import '../../help/app_strings.dart';
import '../../help/custom_image_with_title.dart';
import '../../help/navigate.dart';
import 'components/personel_screens/receipt_record_screen/screen/receipt_record_screen.dart';
import 'components/personel_screens/resignation_screen/resignation_screen.dart';
import 'components/personel_screens/starting_wotk_from_screen/screen/starting_work_form_screen.dart';
import 'components/personel_screens/vacation_form/screen/vacation_form_screen.dart';


class MainPersonnelScreen extends StatelessWidget {
  const MainPersonnelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*
      endDrawer: const CeoDrawer(),
*/
      appBar:  PreferredSize(
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
                'شؤون الموظفين',
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
      body: Column(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: Column(
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        child: CustomImageWithTitleComponent(
                          containerColor: kLightGoldColor,

                          onTap: () {
                            navigatorTo(context, MainReceiptRecordScreen());
                          },
                          image: SvgPicture.asset('assets/images/Group 345.svg'),
                          title: AppStrings.arabicReceiptRecord,
                          textWithEnglish: true,
                          titleEnglish: AppStrings.englishReceiptRecord,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      // Expanded(
                      //   child: CustomImageWithTitleComponent(
                      //     onTap: () {
                      //       navigatorTo(context, DeliveryFormScreen());
                      //     },
                      //     image: SvgPicture.asset(AppImages.infractionImage),
                      //     title: "نموذج التسليم",
                      //     textWithEnglish: true,
                      //     titleEnglish: "Receipt Form",
                      //   ),
                      // ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                        child: CustomImageWithTitleComponent(
                          containerColor: kLightGoldColor,
                          onTap: () {

                            navigatorTo(context, MainResignationScreen());

                          },
                          image: SvgPicture.asset('assets/images/Group 345.svg'),
                          title: AppStrings.arabicResignation,
                          textWithEnglish: true,
                          titleEnglish:AppStrings.englishResignation,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomImageWithTitleComponent(
                          containerColor: kLightGoldColor,

                          onTap: () {
                            navigatorTo(context, MainVacationFormScreen());

                          },
                          image: SvgPicture.asset('assets/images/Group 345.svg'),
                          title: AppStrings.vacationFormAr,
                          textWithEnglish: true,
                          titleEnglish: AppStrings.vacationFormEn,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                        child: CustomImageWithTitleComponent(
                          containerColor: kLightGoldColor,

                          onTap: () {
                            navigatorTo(context, MainStartingWorkFormScreen());
                          },
                          image: SvgPicture.asset('assets/images/Group 345.svg',),
                          title: AppStrings.arabicStartWork,
                          textWithEnglish: true,
                          titleEnglish: AppStrings.englishStartWork,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [

                      Expanded(
                        child: CustomImageWithTitleComponent(
                          containerColor: kLightGoldColor,

                          onTap: () {
                            navigateTo(context, CustodiesScreen());
                          },
                          image: SvgPicture.asset('assets/images/Group 345.svg'),
                          title: 'العهد',
                          textWithEnglish: true,
                          titleEnglish: 'Custodies',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}