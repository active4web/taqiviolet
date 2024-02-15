import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/request_cubit/request_cubit.dart';
import 'package:safsofa/screens/new/personel_page/help/custom_circular_progress/custom_circular_progress.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_drop_down.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';

import '../../shared/constants.dart';

class PartnerOrdersScreen extends StatelessWidget {
  PartnerOrdersScreen({Key? key}) : super(key: key);
  final List<String> items = [
    'موافق',
    'رفض',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'reportsRequests'.tr(),
      ),
      body: BlocConsumer<RequestCubit, RequestState>(
          listener: (context, state) {},
          builder: (context, state) {
            var requestCubit = RequestCubit.get(context);
            return requestCubit.listRequestModel == null
                ? CustomCircularProgress()
                : Padding(
                    padding: EdgeInsets.all(20.0.r),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "productName".tr(),
                                  style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 30.w,),
                                Text(
                                  "price".tr(),
                                  style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "features".tr(),
                                  style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text("status".tr(),style: TextStyle(
                                            fontSize: 12.sp,fontWeight: FontWeight.bold
                                        ),),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomDropDown(
                                                hintColor: Colors.black,
                                                hintText: 'الحاله',
                                                items: [
                                                  'الموافقه على الكل',
                                                  'رفض الكل'
                                                ]
                                                    .map((String item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ))
                                                    .toList(),
                                                onChanged: (value) {},
                                                value: 'value')
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Container(
                                              color: kDarkGoldColor,
                                              padding: EdgeInsets.all(14.r),
                                              child: const Text("okay"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "status".tr(),
                                        style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                // SizedBox.shrink()
                              ],
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            height: 10.h,
                          ),
                          Table(
                            // border: TableBorder.symmetric(
                            //     inside: BorderSide(color: kCustomBlack)),
                            columnWidths: {
                              0: FlexColumnWidth(77.w),
                              1: FlexColumnWidth(30.w),
                              2: FlexColumnWidth(30.w),
                              3: FlexColumnWidth(25.w),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: List.generate(
                              requestCubit.listRequestModel?.data?.length ?? 0,
                              // cubit.searchController.text == ''
                              //     ? cubit.projectsData!.data!.length
                              //     : cubit.searchData.length,
                              (index) => TableRow(
                                decoration: BoxDecoration(color: index%2==0?Colors.white:Colors.grey.shade300),
                                children: [
                                  customText(
                                      title: requestCubit.listRequestModel
                                              ?.data?[index].productName ??
                                          ''),
                                  customText(
                                      title: requestCubit.listRequestModel
                                              ?.data?[index].productCurrentPrice
                                              .toString() ??
                                          ''),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("المميزات"),
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  icon: Icon(
                                                      Icons.cancel_outlined),
                                                )
                                              ],
                                            ),
                                            content: Wrap(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.network(
                                                      requestCubit
                                                              .listRequestModel
                                                              ?.data?[index]
                                                              .image ??
                                                          '',
                                                      height: 200.h,
                                                      width: 150.w,
                                                    ),
                                                    Text(requestCubit
                                                            .listRequestModel
                                                            ?.data?[index]
                                                            .featurDescription?[0] ??
                                                        'لا يوجد مميزات'),
                                                    Row()
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.push_pin,
                                        size: 20.r,
                                      ),
                                    ),
                                  ),
                                  customText(
                                      title: requestCubit.listRequestModel
                                                  ?.data?[index].status ==
                                              0
                                          ? 'منتظر الرد'
                                          : requestCubit.listRequestModel
                                                      ?.data?[index].status ==
                                                  1
                                              ? 'تمت الموافقه'
                                              : "تم الرفض",
                                      onTap: requestCubit.listRequestModel
                                                  ?.data?[index].status ==
                                              0
                                          ? () {
                                        requestCubit.commentController.clear();
                                              showDialog(
                                                context: context,
                                                builder: (ctx) => BlocConsumer<
                                                    RequestCubit, RequestState>(
                                                  listener: (context, state) {
                                                    if (state
                                                        is ChangeStatusSuccess) {
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  builder: (context, state) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text("الحاله"),
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          CustomDropDown<
                                                              SelectState>(
                                                            hintColor:
                                                                Colors.black,
                                                            hintText: 'الحاله',
                                                            items: requestCubit
                                                                .item
                                                                .map((item) =>
                                                                    DropdownMenuItem<
                                                                        SelectState>(
                                                                      value:
                                                                          item,
                                                                      child:
                                                                          Text(
                                                                        item.key
                                                                            .toString(),
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ))
                                                                .toList(),
                                                            onChanged: (value) {
                                                              requestCubit
                                                                      .selected =
                                                                  value;
                                                            },
                                                            value:requestCubit
                                                                .selected??requestCubit.item[0],
                                                          ),
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                          CustomTextFormField(
                                                            textColor: kCustomBlack,
                                                            controller: requestCubit
                                                                .commentController,
                                                            validate: (v) {},
                                                            hintText:
                                                                'تعليق'.tr(),
                                                            hintColor:
                                                                kCustomBlack,
                                                          )
                                                        ],
                                                      ),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            requestCubit.changeStatus(
                                                                id: requestCubit
                                                                    .listRequestModel!
                                                                    .data![
                                                                        index]
                                                                    .id!);
                                                            // Navigator.of(ctx).pop();
                                                          },
                                                          child: Container(
                                                            color:
                                                                kDarkGoldColor,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(14),
                                                            child: const Text(
                                                                "okay"),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              );
                                            }
                                          : null)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          }),
    );
  }
}

Widget customText({required String title, void Function()? onTap}) {
  return Padding(
    padding: EdgeInsets.only(left: 8.0.w, right: 5.w),
    child: InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 8.sp,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}
