import 'package:flutter/material.dart%20';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/services.dart';
import 'package:safsofa/screens/header_my_account/widget/custom_text_form_field.dart';
import 'package:safsofa/screens/header_my_account/widget/gift_card.dart';
import 'package:safsofa/shared/components/custom_button.dart';

class CheckBalanceGiftCardScreen extends StatelessWidget {
  CheckBalanceGiftCardScreen({Key? key}) : super(key: key);
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController personalIdentificationNumberController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text('giftCard'.tr(),
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  controller: cardNumberController,
                  text: 'cardNumber'.tr(),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  controller: personalIdentificationNumberController,
                  text: 'personalIdentificationNumber'.tr(),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      print('object');
                    } else {
                      print('yes');
                    }
                  },
                  height: 50,
                  text: 'checkTheBalance'.tr(),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'sellTheMostGoods'.tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 15,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.4,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 6.0),
                  itemBuilder: (context, index) => GiftCardComponent(),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
