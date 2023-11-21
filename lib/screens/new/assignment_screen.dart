import 'package:flutter/material.dart%20';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/assignment/assignment_cubit.dart';
import 'package:safsofa/screens/new/image_screen.dart';
import 'package:safsofa/screens/new/personel_page/help/custom_circular_progress/custom_circular_progress.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:safsofa/shared/defaults.dart';
import '../../shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'assignment'.tr(),
      ),
      body: BlocProvider(
        create: (context) =>
        AssignmentCubit()
          ..getAssignment(),
        child: BlocConsumer<AssignmentCubit, AssignmentState>(
            listener: (context, state) {},
            builder: (context, state) {
              var assignmentCubit = AssignmentCubit.get(context);
              total(int index){
                return (assignmentCubit.assignmentModel!.data![index].productCurrentPrice!)+(assignmentCubit.assignmentModel!.data![index].insurance!)
                +(assignmentCubit.assignmentModel!.data![index].tax!)+(assignmentCubit.assignmentModel!.data![index].profitProduct!);
              }
              profit(int index){
                return total(index)-((assignmentCubit.assignmentModel!.data![index].developement!)+(assignmentCubit.assignmentModel!.data![index].advertising!)
                    +(assignmentCubit.assignmentModel!.data![index].zakat!)+(assignmentCubit.assignmentModel!.data![index].visaPercentage!));
              }
              return assignmentCubit.assignmentModel == null
                  ? CustomCircularProgress()
                  : Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "theName".tr(),
                              style: TextStyle(fontSize: 10),
                            ),
                            SizedBox(width: 10,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                              child: Text(
                                "price".tr(),
                                style: TextStyle(fontSize: 10.sp),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                              child: Text(
                                "image".tr(),
                                style: TextStyle(fontSize: 10.sp),
                              ),
                            ),
                            Text(
                              "More".tr(),
                              style: TextStyle(fontSize: 10.sp),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Table(
                        columnWidths: {
                          0: FlexColumnWidth(40.w),
                          1: FlexColumnWidth(25.w),
                          2: FlexColumnWidth(30.w),
                          3: FlexColumnWidth(15.w),
                        },
                        defaultVerticalAlignment:
                        TableCellVerticalAlignment.middle,
                        border: TableBorder.symmetric(inside: BorderSide(
                            color: kCustomBlack)),

                        children: List.generate(
                          assignmentCubit.assignmentModel?.data?.length ??
                              0,
                          // cubit.searchController.text == ''
                          //     ? cubit.projectsData!.data!.length
                          //     : cubit.searchData.length,
                              (index) =>
                              TableRow(
                                decoration: BoxDecoration(
                                    color: Colors.white),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0.w),
                                    child: Text(
                                      assignmentCubit.assignmentModel
                                          ?.data?[index].productName ??
                                          '',
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0.w),
                                    child: Text(
                                      assignmentCubit.assignmentModel
                                          ?.data?[index].productCurrentPrice
                                          .toString() ??
                                          '',
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      navigateTo(
                                          context,
                                          ImageScreen(
                                              image: assignmentCubit
                                                  .assignmentModel
                                                  ?.data?[index]
                                                  .image ??
                                                  ''));
                                    },
                                    child: Image.network(
                                      assignmentCubit.assignmentModel
                                          ?.data?[index].image ??
                                          '',
                                      height: 30.h,
                                      width: 30.w,
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) =>
                                                AlertDialog(
                                                  title: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          assignmentCubit.assignmentModel?.data?[index].productName.toString()??'',
                                                          style:
                                                          TextStyle(fontSize: 16),
                                                          maxLines: 2,
                                                          overflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      IconButton(onPressed: () {
                                                        Navigator.pop(ctx);
                                                      },
                                                          icon: Icon(Icons
                                                              .cancel_outlined))
                                                    ],
                                                  ),
                                                  content:
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize:
                                                      MainAxisSize.min,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Image.network(
                                                          assignmentCubit
                                                              .assignmentModel
                                                              ?.data?[
                                                          index]
                                                              .image ??
                                                              '',
                                                          height: 80.h,
                                                          width: 100.w,
                                                        ),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        // Row(
                                                        //   mainAxisAlignment:
                                                        //   MainAxisAlignment
                                                        //       .start,
                                                        //   children: [
                                                        //     Text(
                                                        //       'اسم المنتج:',
                                                        //       style: TextStyle(
                                                        //           fontWeight:
                                                        //           FontWeight
                                                        //               .bold),
                                                        //     ),
                                                        //     SizedBox(
                                                        //       width: 10.w,
                                                        //     ),
                                                        //     Expanded(
                                                        //       child: Text(
                                                        //         assignmentCubit.assignmentModel?.data?[index].productName.toString()??'',
                                                        //         style:
                                                        //         TextStyle(),
                                                        //         maxLines: 2,
                                                        //         overflow:
                                                        //         TextOverflow
                                                        //             .ellipsis,
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                        // SizedBox(
                                                        //   height: 10.h,
                                                        // ),
                                                        CustomItemDialog(
                                                          label:'سعر المنتج',
                                                          price: assignmentCubit.assignmentModel?.data?[index].productCurrentPrice.toString()??''
                                                        ),
                                                        CustomItemDialog(
                                                          label:'التأمين',
                                                          price: assignmentCubit.assignmentModel?.data?[index].insurance.toString()??''
                                                        ),
                                                        CustomItemDialog(
                                                          label:'الضريبه',
                                                          price: assignmentCubit.assignmentModel?.data?[index].tax.toString()??''
                                                        ),
                                                        CustomItemDialog(
                                                          label:'هامش الربح',
                                                          price: assignmentCubit.assignmentModel?.data?[index].profitProduct.toString()??''
                                                        ),
                                                         CustomItemDialog(
                                                          label:'الاجمالي',
                                                          price:total(index).toString()
                                                        ),

                                                        Divider(),
                                                        Text('الخصومات:'),
                                                        CustomItemDialog(
                                                            label:'نسبة التطوير',
                                                            price: assignmentCubit.assignmentModel?.data?[index].developement.toString()??''
                                                        ),
                                                        CustomItemDialog(
                                                            label:'نسبة الدعايا',
                                                            price: assignmentCubit.assignmentModel?.data?[index].advertising.toString()??''
                                                        ),
                                                        CustomItemDialog(
                                                            label:'نسبة الزكاه',
                                                            price: assignmentCubit.assignmentModel?.data?[index].zakat.toString()??''
                                                        ),
                                                        CustomItemDialog(
                                                            label:'وسائل الدفع',
                                                            price: assignmentCubit.assignmentModel?.data?[index].visaPercentage.toString()??''
                                                        ),

                                                        Divider(),
                                                        CustomItemDialog(
                                                            label:'ًصافي الربح',
                                                            price: profit(index).toString()
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                      },
                                      child: Icon(
                                        Icons.more,
                                        size: 15.r,
                                      )),
                                ],

                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }


}



Widget CustomItemDialog
    ({required String label, required String price}) {
  return Row(
    mainAxisAlignment:
    MainAxisAlignment
        .start,
    children: [
      Text(
        '$label:',
        style: TextStyle(
            fontWeight:
            FontWeight
                .bold),
      ),
      SizedBox(
        width: 10.w,
      ),
      Expanded(
        child: Text(
          "${
              price
          } " + "rial".tr(),
          style:
          TextStyle(),
          maxLines: 2,
          overflow:
          TextOverflow
              .ellipsis,
        ),
      ),
    ],
  );

}
