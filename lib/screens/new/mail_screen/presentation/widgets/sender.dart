import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Sender extends StatelessWidget {

  const Sender({Key? key,required this.senderMessage,
  required this.alignment,
    required this.containerColor,
  required this.messageOwner, this.textColor}) : super(key: key);
  final String senderMessage;
  final String messageOwner;
  final Color containerColor;
  final AlignmentDirectional alignment;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.r),
            topStart: Radius.circular(10.r),
            topEnd: Radius.circular(10.r),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.h,
          horizontal: 10.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              messageOwner,
              style: TextStyle(
                color: textColor
              ),
            ),
            SizedBox(height: 3.h,),
            Text(
              senderMessage,
              style: TextStyle(
                color: textColor
              ),
            ),
          ],
        ),
      ),
    );
  }
}
