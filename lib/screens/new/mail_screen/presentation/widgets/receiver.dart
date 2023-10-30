import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safsofa/shared/constants.dart';


class Receiver extends StatelessWidget {
  final String receiverMessage;
  final String title;
  const Receiver({Key? key, required this.receiverMessage,
  required this.title}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        width: width,
        decoration: BoxDecoration(
            color: kDarkGoldColor,

            borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.r),
            topStart: Radius.circular(10.r),
            topEnd: Radius.circular(10.r),
          ),
          border: Border.all(
            color: kDarkGoldColor,

          )
        ),
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.sp,
                    child: SvgPicture.asset('assets/images/download.png',height: double.infinity),
                  ),
                  SizedBox(width: 12.w,),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 14.sp,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h,),
              Text(
                receiverMessage,style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 18.sp
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
