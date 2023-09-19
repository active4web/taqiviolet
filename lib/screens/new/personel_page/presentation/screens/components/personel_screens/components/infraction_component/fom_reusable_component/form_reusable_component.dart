import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class FormReusableComponent extends StatelessWidget {
  final String arabicTitle;
  final String englishTitle;
  bool? isVacation;
    FormReusableComponent({Key? key,
   required this.englishTitle,
   required this.arabicTitle,
   this.isVacation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        if(isVacation==null)
          Text(arabicTitle,
          style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w200
          ),),
        if(isVacation!=null)
          Expanded(
          child: Text(arabicTitle,
            style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w200
            ),),
        ),
        SizedBox(height: 10.h,),
        Text(englishTitle,
          style: TextStyle(
              fontSize: 10.sp,
              fontWeight: isVacation==null?FontWeight.w200:FontWeight.w400
          ),),
      ],
    );
  }
}
