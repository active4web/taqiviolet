import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_label.dart';

class TechnicalSupportScreen extends StatelessWidget {
  const TechnicalSupportScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'TechnicalSupport'.tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Label(text: 'RequestHelp'.tr()),
              SizedBox(
                height: 30,
              ),
              CustomButton(
                height: 50,
                text: 'CreateRequest'.tr(),
              ),
              SizedBox(
                height: 30,
              ),
              RequestCard(),
              SizedBox(
                height: 20,
              ),
              RequestCard(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  const RequestCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 1)]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'مشكله في الطلب الخاص بي',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '27-11-2020',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                '3:30 AM',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'تم الحل',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
