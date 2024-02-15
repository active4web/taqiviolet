import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/expenses/expenses_cubit.dart';
import 'package:safsofa/screens/new/pdf_view.dart';
import 'package:safsofa/screens/new/personel_page/help/custom_circular_progress/custom_circular_progress.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast_states.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../shared/constants.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'expenses'.tr(),
      ),
      body: BlocProvider(
        create:(context)=> ExpensesCubit()..getExpenses(),
        child: BlocConsumer<ExpensesCubit,ExpensesState>(
          listener: (context,state){},
          builder: (context,state) {
            var expensesCubit=ExpensesCubit.get(context);
            return expensesCubit.expensesModel==null?CustomCircularProgress(): Padding(
              padding:  EdgeInsets.all(20.0.r),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTitle(
                            title: "clause".tr(),
                          ),
                          CustomTitle(
                            title: "value".tr(),
                          ),
                          CustomTitle(
                            title: 'date'.tr(),
                          ),
                          CustomTitle(
                            title: 'features'.tr(),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 4.h,
                    ),
                    Table(
                      // defaultColumnWidth: FixedColumnWidth(20.0),
                      // border: TableBorder.all(
                      //     color: Colors.black,
                      //     style: BorderStyle.solid,
                      //     width: 2),
                      columnWidths: {
                        0: FlexColumnWidth(30.w),
                        1: FlexColumnWidth(22.w),
                        2: FlexColumnWidth(30.w),
                        3: FlexColumnWidth(15.w),

                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      // border: TableBorder.symmetric(inside: BorderSide(color: kCustomBlack)),

                      children: List.generate(
                        expensesCubit.expensesModel?.data?.length??0,
                        // cubit.searchController.text == ''
                        //     ? cubit.projectsData!.data!.length
                        //     : cubit.searchData.length,
                        (index) => TableRow(
                          decoration: BoxDecoration(
                              color: index%2==0?Colors.grey.shade300 :Colors.white),
                          children: [
                            CustomText(text: expensesCubit.expensesModel?.data?[index].details??''),
                            CustomText(text: expensesCubit.expensesModel?.data?[index].totalMoney??'0'),
                            CustomText(text: expensesCubit.expensesModel?.data?[index].createdAt??''),
                            InkWell(onTap:expensesCubit.expensesModel?.data?[index].file==null?(){
                              ToastConfig.showToast(msg: 'file is empty', toastStates: ToastStates.success);
                            } :(){
                              navigateTo(context, PdfView(url: expensesCubit.expensesModel?.data?[index].file??''));
                            },child: Icon(Icons.push_pin,size: 25,))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}

Widget CustomText({required String text}) {
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
    child: Text(
      text,
      style: TextStyle(fontSize: 8.sp),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget CustomTitle({required String title}) {
  return Padding(
    padding: const EdgeInsets.only(left: 0.0),
    child: Text(
      title,
      style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.bold),
    ),
  );
}
