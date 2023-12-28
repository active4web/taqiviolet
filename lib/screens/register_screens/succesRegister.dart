import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/router.dart';

class SuccessRegister extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor:Colors.white),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/images/correct.png"),
          ),
          Text("SuccessInRegister".tr()),
          CustomButton(
            text: 'SuccessOrder'.tr(),
            height: 50,
            onTap: () {
             MagicRouter.pop();
            },
          )

        ],
      ),
    );
  }
}
