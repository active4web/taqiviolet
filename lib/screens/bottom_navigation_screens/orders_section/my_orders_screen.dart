import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Orders'.tr(),
      ),
      body: Column(
        children: [
          Container(
            height: height / 15,
            width: width,
            color: Colors.white,
            child: TabBar(
              labelColor: kCustomBlack,
               isScrollable: true,
              labelStyle: TextStyle(
                fontSize: 12.sp
              ),
              indicatorColor: kCustomBlack,
              unselectedLabelColor: Colors.black,
              controller: _tabController,
              tabs: MyOrdersCubit.get(context).tabs,
            ),
          ),
          Expanded(
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
