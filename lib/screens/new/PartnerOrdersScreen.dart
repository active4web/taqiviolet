import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/cubits/request_cubit/request_cubit.dart';
import 'package:safsofa/screens/new/personel_page/help/custom_circular_progress/custom_circular_progress.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_drop_down.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/src/public_ext.dart';

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
      body:BlocProvider(
        create: (context)=>RequestCubit()..getListRequest(),
        child: BlocConsumer<RequestCubit,RequestState>(
          listener: (context,state){},
          builder: (context,state) {
            var requestCubit=RequestCubit.get(context);
            return requestCubit.listRequestModel==null? CustomCircularProgress():Padding(
              padding:  EdgeInsets.all( 20.0.r),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                            child: Text(
                              "productName".tr(),
                              style: TextStyle(
                                  fontSize: 10.sp
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 25.0.w),
                            child: Text(
                              "price".tr(),
                              style: TextStyle(
                                  fontSize: 10.sp
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 0.0.w),
                            child: Text(
                              "image".tr(),
                              style: TextStyle(
                                  fontSize: 10.sp
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          GestureDetector(
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title:  Text("status".tr()),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomDropDown(hintColor: Colors.black,hintText: 'الحاله', items: ['الموافقه على الكل','رفض الكل']
                                          .map((String item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style:  TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(), onChanged: (value){}, value: 'value')
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        color:kDarkGoldColor,
                                        padding:  EdgeInsets.all(14.r),
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
                                  style: TextStyle(
                                      fontSize: 10
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Table(
                      border: TableBorder.symmetric(inside: BorderSide(color: kCustomBlack)),
                      columnWidths: {
                        0: FlexColumnWidth(70.w),
                        1: FlexColumnWidth(30.w),
                        2: FlexColumnWidth(22.w),
                        3: FlexColumnWidth(30.w),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,

                      children: List.generate(requestCubit.listRequestModel?.data?.length??0,
                        // cubit.searchController.text == ''
                        //     ? cubit.projectsData!.data!.length
                        //     : cubit.searchData.length,
                            (index) =>
                                TableRow(
                          decoration: BoxDecoration(
                              color:  Colors.white),
                          children: [
                            customText(title: requestCubit.listRequestModel?.data?[index].productName??''),
                            customText(title: requestCubit.listRequestModel?.data?[index].productCurrentPrice.toString()??''),

                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: InkWell(
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(

                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("المميزات"),
                                          IconButton(onPressed: (){
                                            Navigator.of(ctx).pop();

                                          }, icon:Icon(Icons.cancel_outlined),
                                          )
                                        ],
                                      ),
                                      content:  Text(requestCubit.listRequestModel?.data?[index].featurDescription?[0]??'لا يوجد مميزات'),
                                    ),
                                  );
                                },
                                child: Image.network(requestCubit.listRequestModel?.data?[index].image??'',
                                  height: 30,
                                  width: 50,
                                ),
                              ),
                            ),
                            customText(title: 'منتظر الرد',onTap: (){
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("الحاله"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomDropDown(hintColor: Colors.black,hintText: 'الحاله', items: items
                                      .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                                      .toList(), onChanged: (value){}, value: 'value')
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        color:kDarkGoldColor,
                                        padding: const EdgeInsets.all(14),
                                        child: const Text("okay"),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })
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

Widget customText({required String title,void Function()? onTap}){
  return  Padding(
    padding:  EdgeInsets.only(left: 8.0.w,right: 5.w),
    child: InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 10,
        ),maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );

}