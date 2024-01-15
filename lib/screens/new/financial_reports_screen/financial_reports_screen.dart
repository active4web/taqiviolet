import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/screens/new/financial_reports_screen/cubit/financial_reports_cubit.dart';
import 'package:safsofa/screens/new/financial_reports_screen/widgets/current_order_list_view.dart';
import 'package:safsofa/screens/new/financial_reports_screen/widgets/cusom_dialog_box.dart';
import 'package:safsofa/screens/new/financial_reports_screen/widgets/holding_order_list_view.dart';
import 'package:safsofa/screens/new/financial_reports_screen/widgets/old_order_list_view.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:safsofa/shared/constants.dart';

import '../../../network/local/cache_helper.dart';
import 'widgets/wating_order_list_view.dart';

class FinancialReportsScreen extends StatefulWidget {
  const FinancialReportsScreen({Key? key}) : super(key: key);

  @override
  State<FinancialReportsScreen> createState() => _FinancialReportsScreenState();
}

class _FinancialReportsScreenState extends State<FinancialReportsScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    if(CacheHelper.getData('type')==3){
      FinancialReportsCubit.get(context)..getSalesOrder();
    }else{
      FinancialReportsCubit.get(context)..getWatingOrders()..getCurrentOrders()..getHoldingOrders()..getOldOrders();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TabController _tabController = TabController(
        initialIndex: 0,
        length: FinancialReportsCubit.get(context).tabs.length,
        vsync: this);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'sales'.tr(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(CacheHelper.getData('type')==0)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text("المتبقى"),
                            Text("200"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("الربح"),
                            Text("200"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("رأس المال"),
                            Text("200"),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text("اجمالي المبيعات"),
                            Text("200"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("الزائرين"),
                          Text("200"),
                        ],
                      ),

                      Column(
                        children: [
                          Text("المستخدمين"),
                          Text("200"),
                        ],
                      ),

                      Column(
                        children: [
                          Text("المخزن"),
                          Text("200"),
                        ],
                      ),
                      Column(
                        children: [
                          Text("المصاريف"),
                          Text("200"),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),

            Container(
              height: height / 20,
              width: width,
              color: Colors.white,
              child: TabBar(
                unselectedLabelStyle: TextStyle(
                  fontSize: 11.sp
                ),
                labelStyle: TextStyle(
                  fontSize: 11.sp
                ),
                labelColor: kCustomBlack,
                isScrollable: true,
                indicatorColor: kCustomBlack,
                unselectedLabelColor: Colors.black,
                controller: _tabController,
                tabs: FinancialReportsCubit.get(context).tabs,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  WatingOrderListView(),
                  CurrentOrderListView(),
                  HoldingOrderListView(),
                  OldOrderLisView(),
                ],
              ),
            ),

            // Row(
            //   children: [
            //     Expanded(
            //         child: InkWell(
            //           onTap: (){
            //
            //           },
            //           child: Container(
            //             child:  Center(
            //               child: Text(
            //                 "الارباح والخساير",
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                   color: Colors.black87,
            //                 ),
            //               ),
            //             ),
            //             height: 120,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               color: Colors.white,
            //               border: Border.all(
            //                 color: Colors.grey.withOpacity(0.5),
            //               ),
            //             ),
            //           ),
            //         )),
            //     SizedBox(width: 10,),
            //     Expanded(
            //         child: InkWell(
            //           onTap: (){
            //
            //           },
            //           child: Container(
            //             child:  Center(
            //               child: Text(
            //                 "اجمالى الدخل",
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                   color: Colors.black87,
            //                 ),
            //               ),
            //             ),
            //             height: 120,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               color: Colors.white,
            //               border: Border.all(
            //                 color: Colors.grey.withOpacity(0.5),
            //               ),
            //             ),
            //           ),
            //         )),
            //   ],
            // ),
            // SizedBox(height: 20,),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     InkWell(
            //       onTap: (){
            //
            //       },
            //       child: Container(
            //         padding: EdgeInsets.symmetric(horizontal: 15.w),
            //         child:  Center(
            //           child: Text(
            //             "المصروفات الكلية",
            //             style: TextStyle(
            //               fontSize: 20,
            //               color: Colors.black87,
            //             ),
            //           ),
            //         ),
            //         height: 120,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           color: Colors.white,
            //           border: Border.all(
            //             color: Colors.grey.withOpacity(0.5),
            //           ),
            //         ),
            //       ),
            //     ),
            //     // SizedBox(width: 10,),
            //     // Expanded(
            //     //     child: InkWell(
            //     //       onTap: (){
            //     //
            //     //       },
            //     //       child: Container(
            //     //         child:  Center(
            //     //           child: Text(
            //     //             "بنود غير مسواة",
            //     //             style: TextStyle(
            //     //               fontSize: 20,
            //     //               color: Colors.black87,
            //     //             ),
            //     //           ),
            //     //         ),
            //     //         height: 120,
            //     //         decoration: BoxDecoration(
            //     //           borderRadius: BorderRadius.circular(10),
            //     //           color: Colors.white,
            //     //           border: Border.all(
            //     //             color: Colors.grey.withOpacity(0.5),
            //     //           ),
            //     //         ),
            //     //       ),
            //     //     )),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
