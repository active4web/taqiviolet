import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/screens/new/financial_reports_screen/cubit/financial_reports_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:safsofa/shared/defaults.dart';
import '../../../../shared/constants.dart';
import '../../../bottom_navigation_screens/orders_section/order_details.dart';
import 'cusom_dialog_box.dart';

class CurrentOrderListView extends StatelessWidget {
  const CurrentOrderListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinancialReportsCubit, FinancialReportsState>(
      builder: (context, state) {
        var cubit=FinancialReportsCubit.get(context);
        return AnimatedConditionalBuilder(condition: cubit.current!=null, builder: (context)=>
            AnimatedConditionalBuilder(condition: cubit.current?.isNotEmpty??cubit.current==[], builder: (context)=>
                ListView.separated(
                  itemCount: cubit.current?.length??0,
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
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  Text(cubit.current?[index].codeOrder.toString()??'',style: TextStyle(
                                    fontSize: 10.sp,
                                  ),),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('اجمالي الطلب: ',style: TextStyle(
                                      fontSize: 11.sp,

                                      fontWeight: FontWeight.bold
                                  ),),
                                  Expanded(child: Text('${cubit.current?[index].total?.toStringAsFixed(2)} ${'rial'.tr()}',style: TextStyle(
                                    fontSize: 10.sp,
                                  ),)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('عدد المنتجات: ',style: TextStyle(
                                      fontSize: 11.sp,

                                      fontWeight: FontWeight.bold
                                  ),),
                                  Text(cubit.current?[index].productsConut.toString()??'',style: TextStyle(
                                    fontSize: 10.sp,
                                  ),),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('تاريخ الطلب: ',style: TextStyle(
                                      fontSize: 11.sp,

                                      fontWeight: FontWeight.bold
                                  ),),
                                  Expanded(child: Text(cubit.current?[index].createdAt??'',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(
                                    fontSize: 10.sp,
                                  ),)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: (){
                                cubit.changeStatus(orderId: num.parse(cubit.current![index].id!.toString()), status: cubit.current?[index].status=='6'?3:4);
                              },
                              child: Container(
                                padding: EdgeInsets.all(5.r),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    color:cubit.current?[index].status=='6'? kCustomBlack:Colors.green.shade900),
                                child:Text(
                                 cubit.current?[index].status=='6'? 'جاري التجهيز':'جاري التوصيل',
                                  style: TextStyle(color: Colors.white,                                      fontSize: 11.sp,
                                  ),

                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            TextButton(onPressed: (){
                              navigateTo(context, OrderDetailsSCR(
                                id: cubit.current![index].id!.toInt(),
                              ));
                            }, child: Text(
                              'تفاصيل الطلب',style: TextStyle(
                                fontSize: 11.sp,

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
                  child: Text('لا يوجد طلبات حاليا',style: TextStyle(
                    fontSize: 11.sp,

                  ),),
                )
            ), fallback: (context)=>
            Center(
              child: CircularProgressIndicator(),
            ));
      },
    );
  }
}
