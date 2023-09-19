import 'package:flutter/material.dart%20';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/screens/new/personel_page/help/custom_circular_progress/custom_circular_progress.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../cubits/inventory/inventory_cubit.dart';
import '../../shared/constants.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'inventory'.tr(),
      ),
      body: BlocProvider(
        create: (context)=>InventoryCubit()..getInventoryList(),
        child: BlocConsumer<InventoryCubit,InventoryState>(
          listener: (context,state){},
          builder: (context,state) {
            var inventoryCubit=InventoryCubit.get(context);
            return inventoryCubit.inventoryModel==null?CustomCircularProgress():Padding(
              padding: EdgeInsets.all(20.0.r),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "basicQuantity".tr(),
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          Text(
                            "quantitySold".tr(),
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          Text(
                            "remaining".tr(),
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          Text(
                            "productImage".tr(),
                            style: TextStyle(fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Table(
                      columnWidths: {
                        0: FlexColumnWidth(30.w),
                        1: FlexColumnWidth(30.w),
                        2: FlexColumnWidth(22.w),
                        3: FlexColumnWidth(22.w),
                      },
                      border: TableBorder.symmetric(inside: BorderSide(color: kCustomBlack)),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,

                      children: List.generate(
                        inventoryCubit.inventoryModel?.data?.length??0,
                        // cubit.searchController.text == ''
                        //     ? cubit.projectsData!.data!.length
                        //     : cubit.searchData.length,
                        (index) => TableRow(
                          decoration: BoxDecoration(
                              color:  Colors.white),
                          children: [
                            customInventoryText(text: inventoryCubit.inventoryModel?.data?[index].productQuantityOrignal??''),
                            customInventoryText(text: inventoryCubit.inventoryModel?.data?[index].productQuantitySold.toString()??''),
                            customInventoryText(text:  inventoryCubit.inventoryModel?.data?[index].productQuantity??''
                            ),
                            InkWell(
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title:Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'المزيد',
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
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                     children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text('اسم المنتج:',style: TextStyle(
                                              fontWeight: FontWeight.bold
                                            ),),
                                            SizedBox(width: 10.w,),
                                            Expanded(
                                              child: Text(inventoryCubit.inventoryModel?.data?[index].productName??'',style: TextStyle(
                                              ),maxLines: 3,overflow: TextOverflow.ellipsis,),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 30.h,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text('سعر المنتج:',style: TextStyle(
                                              fontWeight: FontWeight.bold
                                            ),),
                                            SizedBox(width: 10.w,),
                                            Expanded(
                                              child: Text(inventoryCubit.inventoryModel?.data?[index].productCurrentPrice.toString()??'0',style: TextStyle(
                                              ),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),

                                  ),
                                );
                              },
                              child: Image.network(
                                inventoryCubit.inventoryModel?.data?[index].image??'',
                                height: 30,
                                width: 30,
                              ),
                            ),
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

Widget customInventoryText({required String text}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Text(
      text,
      style: TextStyle(fontSize: 10.sp),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
