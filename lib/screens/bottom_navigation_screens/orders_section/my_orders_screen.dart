import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/cubits/my_orders_cubit.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/constants.dart';

class MyOrdersScreen extends StatefulWidget {

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TabController _tabController = TabController(
        initialIndex: 0,
        length: MyOrdersCubit.get(context).tabs.length,
        vsync: this);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Orders'.tr(),
      ),
      body: ListView(
        children: [
          Container(
            height: height / 15,
            width: width,
            color: Colors.white,
            child: TabBar(
              labelColor: kDarkGoldColor,
              // isScrollable: true,
              indicatorColor: kDarkGoldColor,
              unselectedLabelColor: Colors.black,
              controller: _tabController,
              tabs: MyOrdersCubit.get(context).tabs,
            ),
          ),
          SizedBox(
            height: (height - (height / 15)),
            child: TabBarView(
              controller: _tabController,
              children: MyOrdersCubit.get(context).tabBarsContent,
            ),
          ),
        ],
      ),
    );
  }
}
