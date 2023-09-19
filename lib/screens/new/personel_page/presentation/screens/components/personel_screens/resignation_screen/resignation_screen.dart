import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../../../shared/constants.dart';
import '../../../../../help/app_strings.dart';
import '../../../../../help/custom_bottom_without_border.dart';
import '../components/receipt_record_component/custom_form_field_without_border.dart';

class MainResignationScreen extends StatelessWidget {
  MainResignationScreen({Key? key}) : super(key: key);
var numberController=TextEditingController();
var dateController=TextEditingController();
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
             SvgPicture.asset('assets/images/logo.png',
              width: 70.w) ,
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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.arabicResignation,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    AppStrings.englishResignation,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "رقم",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 15.sp
                    ),
                  ),
                  Container(
                    width: 100.w,
                    height: 30.h,
                    child: MainCustomFormFieldWithoutBorder(
                        controller: numberController,
                        validator: (value){},
                        keyBoardType: TextInputType.number),
                  ),
                  Text(
                    "No:",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 15.sp
                    ),
                  ),
                  Text(
                    "التاريخ",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 15.sp
                    ),
                  ),
                  Container(
                    width: 100.w,
                    height: 30.h,
                    child: TextFormField(
                      onTap: () async {
                        await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2050))
                            .then((value) {
                          print(value);
                          dateController.text =
                          "${value!.day}-${value.month}-${value.year}";
                        });
                      },
                      controller: dateController,
                      decoration:InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      keyboardType: TextInputType.none,
                    ),
                  ),
                  Text(
                    "Date:",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 15.sp
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 18.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomBottomWithoutBorder(function: (){}, text: "تم",
                    width: 120.w,
                    height: 25.h,
                  ),
                  SizedBox(width: 10.w,),
                  CustomBottomWithoutBorder(function: (){}, text: "طباعه",
                    width: 120.w,
                    height: 25.h,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
