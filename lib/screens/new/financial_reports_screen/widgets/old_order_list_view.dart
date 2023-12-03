import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/screens/new/financial_reports_screen/cubit/financial_reports_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/defaults.dart';
import '../../../bottom_navigation_screens/orders_section/order_details.dart';
import 'cusom_dialog_box.dart';

class OldOrderLisView extends StatelessWidget {
  const OldOrderLisView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinancialReportsCubit, FinancialReportsState>(
      builder: (context, state) {
        var cubit=FinancialReportsCubit.get(context);
        return AnimatedConditionalBuilder(condition: cubit.oldOrderModel!=null, builder: (context)=>
            AnimatedConditionalBuilder(condition: cubit.oldOrderModel?.data?.isNotEmpty??cubit.oldOrderModel?.data==[], builder: (context)=>
                ListView.separated(
                  itemCount: cubit.oldOrderModel?.data?.length??0,
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('رقم الطلب: ',style: TextStyle(

                                      fontWeight: FontWeight.bold
                                  ),),
                                  Text(cubit.oldOrderModel?.data?[index].codeOrder.toString()??''),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('اجمالي الطلب: ',style: TextStyle(

                                      fontWeight: FontWeight.bold
                                  ),),
                                  Expanded(child: Text('${cubit.oldOrderModel?.data?[index].total} ${'rial'.tr()}')),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('عدد المنتجات: ',style: TextStyle(

                                      fontWeight: FontWeight.bold
                                  ),),
                                  Text('3'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('تاريخ الطلب: ',style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),),
                                  Expanded(child: Text(cubit.oldOrderModel?.data?[index].orderDate??'',maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5.r),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: kCustomBlack),
                              child:Text(
                               'تم التوصيل',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            TextButton(onPressed: (){
                              navigateTo(context, OrderDetailsSCR(
                                id: cubit.oldOrderModel!.data![index].id!.toInt(),
                              ));
                            },
                                child: Text(
                              'تفاصيل الطلب',style: TextStyle(
                                color: kCustomBlack,fontWeight: FontWeight.bold
                            ),
                            ))
                          ],
                        )

                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 5.h,
                  ),
                ), fallback: (context)=>
                Center(
                  child: Text('لا يوجد طلبات حاليا'),
                )
            ), fallback: (context)=>
            Center(
              child: CircularProgressIndicator(),
            ));
      },
    );
  }
}