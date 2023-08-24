import 'package:flutter/material.dart';
import 'package:safsofa/screens/home_layout.dart';
import 'package:safsofa/screens/send_a_gift_screen.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:safsofa/shared/defaults.dart';
import '../models/MakeOrderNewNewNewModel.dart';
import '../models/make_order_model.dart';

class SuccessScr extends StatelessWidget {
  SuccessScr(
      // this.makeOrderModel,
      this.makeOrderNewNewNewModel);
  // final MakeOrderModel makeOrderModel;
  final MakeOrderNewNewNewModel makeOrderNewNewNewModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/images/succ.png"),
          Text(
            "yourOrderHasBeenCompletedSuccessfully".tr(),
            style: TextStyle(
              color: kDarkGoldColor,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "${"orderNo".tr()} #${makeOrderNewNewNewModel.data}",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CustomButton(
                    text: "continueShopping".tr(),
                    onTap: () => navigateAndFinish(context, HomeLayout()),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomButton(
                    text: 'sendagift'.tr(),
                    onTap: (){
                      navigateTo(
                          context,
                          SendAGiftScreen(
                            orderId: makeOrderNewNewNewModel.data?.id,
                          ));
                    }
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
