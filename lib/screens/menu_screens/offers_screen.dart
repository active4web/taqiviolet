import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/screens/bottom_navigation_screens/home_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Offers'.tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              BigOfferCard(),
              SizedBox(
                height: 20,
              ),
              OffersListView(),
              SizedBox(
                height: 20,
              ),
              BigOfferCard(),
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

class BigOfferCard extends StatelessWidget {
  const BigOfferCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 1)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/images/furniture.png'),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    Text(
                      'خصومات خاصة',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      ' 50 % على الأثاث المنزلي',
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20)),
              color: Colors.white,
            ),
            child: Text(
              'احصل على 50% خصم',
              style: TextStyle(fontSize: 12),
            ),
          ),
        )
      ],
    );
  }
}
