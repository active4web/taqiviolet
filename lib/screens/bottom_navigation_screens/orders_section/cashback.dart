import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/cartCubit/cart_cubit.dart';
import 'package:safsofa/cubits/cartCubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/custom_text_form_field.dart';
import '../../../shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../new/personel_page/help/custom_circular_progress/custom_circular_progress.dart';
class CashBack extends StatelessWidget {
  const CashBack({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        var cubit=CartCubit.get(context);
        return Form(
          key: cubit.cashFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (cubit.myCartModel!.data!.cashback == 0)
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal:20.w),
                  child: Text('dontHaveCash'.tr(),
                  style: TextStyle(
                      fontSize: 10.sp
                  ),),
                ),
              if (cubit.myCartModel!.data!.cashback != 0)
                SizedBox(
                  height: 10.h,
                ),
              if (cubit.myCartModel!.data!.cashback != 0)
              Padding(
                padding:  EdgeInsets.symmetric(horizontal:20.w),
                child: Text('${'have'.tr()} ${cubit.myCartModel!.data!.cashback} ${'cashBack'.tr()}',
                style: TextStyle(
                  fontSize: 10.sp
                ),),
              ),
              if (cubit.myCartModel!.data!.cashback != 0)
                CustomTextFormField(
                  suffix: InkWell(
                    onTap: () {
                      if (CartCubit.get(context).cashback.text.isNotEmpty&&cubit.validCashback!=true) {
                        if(cubit.cashFormKey.currentState!.validate())
                        CartCubit.get(context).checkCachBack();
                      }else if(cubit.cache){
                        cubit.cancelCashback();
                      }
                    },
                    child: Container(
                      width: 90.w,

                      child: Center(
                        child: state is CheckPromoLoadingState
                            ? CustomCircularProgress()
                            : cubit.validCashback
                            ? Text(
                          'الغاء التفعيل',
                          style: TextStyle(color: kLightGoldColor),
                        )
                            : Text(
                          'Redeem'.tr(),
                          style: TextStyle(color: kLightGoldColor),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: kCustomBlack,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  controller: cubit.cashback,
                  fillColor: Colors.grey.shade500,
                  hintColor: Colors.black,
                  textColor: Colors.black,
                  cursorColor: kDarkGoldColor,
                  keyboardType: TextInputType.phone,
                  validate: (value) {
                    if(value!.length>0){
                      if(int.parse(value)>cubit.myCartModel!.data!.cashback!.toInt()){
                        return 'ليس لديك رصيد كافي';
                      }
                    }
                  },
                  onChanged: (value){

                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
