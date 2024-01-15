import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/my_orders_cubit.dart';
import 'package:safsofa/screens/bottom_navigation_screens/orders_section/search_result_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_app_bar_with_search.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

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
      appBar: CustomAppBarWithSearch(
        title: 'Orders'.tr(),
        controller: MyOrdersCubit.get(context).searchController,
        onSaved: (value){
          MyOrdersCubit.get(context).searchOrder();
          navigateTo(context, SearchResultScreen());
        },
      ),
      body: Column(
        children: [
          Container(
            height: height / 15,
            color: Colors.white,
            child: TabBar(
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
              labelColor: kCustomBlack,
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
            child: Container(
              child: TabBarView(
                controller: _tabController,
                children: MyOrdersCubit.get(context).tabBarsContent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
