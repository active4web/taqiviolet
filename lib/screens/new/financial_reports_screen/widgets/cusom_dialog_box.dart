import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/screens/new/financial_reports_screen/cubit/financial_reports_cubit.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import '../../../../shared/components/custom_text_form_field.dart';
import '../../../../shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';

void showCustomDialog(BuildContext context, num orderId,int status) {
  FinancialReportsCubit.get(context).isHold=false;
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return AlertDialog(
        content: BlocConsumer<FinancialReportsCubit, FinancialReportsState>(
          listener: (context, state) {
            if(state is ChangeStatusSuccess){
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            var cubit=FinancialReportsCubit.get(context);
            return Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        cubit.changeStatus(orderId: orderId, status:status);
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: kCustomBlack),
                        child: Text(
                          'جاري التجهيز',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    // Spacer(),
                    InkWell(
                      onTap: (){
                        cubit.changeHoldState();
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Colors.red.shade900),
                        child: Text(
                          'تعليق الطلب',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                  
                if(cubit.isHold)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomTextFormField(
                      // fontSize: 12.sp,
                      hintText: "Comment".tr(),
                      controller: cubit.commentController,
                      fillColor: Colors.grey.shade500,
                      hintColor: Colors.black,
                      textColor: Colors.black,
                      cursorColor: kDarkGoldColor,
                      keyboardType: TextInputType.text,
                      validate: (value) {
                      },
                    ),
                  ),
                if(cubit.isHold)
                  CustomButton(onTap: (){
                    cubit.changeStatus(orderId: orderId, status: 4);
                  },text: 'تعليق الطلب'.tr(),)

              ],
            );
          },
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}