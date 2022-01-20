import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Home".tr()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.bell),
            onPressed: () {},
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xfff6f6f6)),
              child: Carousel(
                images: [
                  ExactAssetImage("assets/images/panner1.png"),
                  ExactAssetImage("assets/images/panner1.png"),
                  ExactAssetImage("assets/images/panner1.png"),
                ],
                dotSize: 10,
                dotSpacing: 20.0,
                dotColor: Color(0xffF3E184),
                indicatorBgPadding: 5.0,
                dotBgColor: Colors.transparent,
                animationCurve: Curves.easeIn,
                borderRadius: true,
                autoplay: false,
                dotIncreaseSize: 1.2,
                dotIncreasedColor: kDarkGoldColor,
                noRadiusForIndicator: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: HomeCard()),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 220,
                        child: HomeCard(),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 120,
                        child: HomeCard(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 120,
                        child: HomeCard(),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 220,
                        child: HomeCard(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ShowOffersCard(),
                  SizedBox(
                    height: 20,
                  ),
                  Label(
                    text: "OffersAndDiscounts".tr(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OffersListView(),
                  SizedBox(
                    height: 20,
                  ),
                  Label(
                    text: 'OtherServices'.tr(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: HomeCard(),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: HomeCard(),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
            )
          ],
        ),
      ),
    );
  }
}

class OffersListView extends StatelessWidget {
  const OffersListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.height * 0.30,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 1)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/dacey.png'))),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'EnjoySpecialOffers'.tr(),
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '50%OFF',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            height: 22,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                'ShopNow'.tr(),
                                style: TextStyle(
                                    fontSize: 11, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
          itemCount: 5),
    );
  }
}

class ShowOffersCard extends StatelessWidget {
  const ShowOffersCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/chair1.png'))),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'EnjoyOffersAndDiscounts'.tr(),
                  style: TextStyle(
                      color: kDarkGoldColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'DiscountsAndOffers'.tr(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                CustomButton(
                  text: 'SeeOffers'.tr(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.black87, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text(
            'ServiceName'.tr(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
