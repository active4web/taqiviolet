import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/screens/bottom_navigation_screens/my_account_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/constants.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Orders'.tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Label(
                text: 'UnderWayOrders'.tr(),
              ),
              SizedBox(
                height: 10,
              ),
              OrderStatusCard(
                status: 1,
              ),
              SizedBox(
                height: 20,
              ),
              Label(
                text: 'PreviousOrders'.tr(),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => OrderStatusCard(),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: 7)
            ],
          ),
        ),
      ),
    );
  }
}

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({
    Key key,
    this.status = 2,
  }) : super(key: key);

  final int status;
  // 1 = underway , 2 = done , 3 = canceled
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xfff4f4f4), borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '1-12-2021',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: Text(
                        'OrderNumber'.tr(),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                    Text(
                      '#1893',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: Text(
                        'DeliveryTime'.tr(),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                    Text(
                      '12-12-2021',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'OrderDetails'.tr(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: kDarkGoldColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              if (status == 1)
                StatusChip(
                  title: 'UnderWay'.tr(),
                  color: kDarkGoldColor,
                )
              else if (status == 2)
                StatusChip(
                  title: 'Received'.tr(),
                  color: Colors.green,
                )
              else if (status == 3)
                StatusChip(
                  title: 'Canceled'.tr(),
                  color: Colors.red,
                ),
              SizedBox(
                height: 10,
              ),
              status != 1
                  ? StatusChip(
                      color: Colors.black,
                      title: 'ReOrder'.tr(),
                    )
                  : SizedBox(
                      height: 30,
                    ),
            ],
          )
        ],
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  const StatusChip({
    Key key,
    this.title,
    this.color,
  }) : super(key: key);

  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
