import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/cartCubit/cart_cubit.dart';
import 'package:safsofa/cubits/cartCubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/custom_text_form_field.dart';
import '../../../shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
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
                  child: Text('dontHaveCash'.tr()),
                ),
              if (cubit.myCartModel!.data!.cashback != 0)
                SizedBox(
                  height: 10,
                ),
              if (cubit.myCartModel!.data!.cashback != 0)
              Padding(
                padding:  EdgeInsets.symmetric(horizontal:20.w),
                child: Text('${'have'.tr()} ${cubit.myCartModel!.data!.cashback} ${'cashBack'.tr()}'),
              ),
              if (cubit.myCartModel!.data!.cashback != 0)
                CustomTextFormField(
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
                    if(value.length>0){
                    cubit.cashFormKey.currentState?.validate();}
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
