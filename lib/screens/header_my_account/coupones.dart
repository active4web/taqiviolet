import 'package:flutter/material.dart';
import 'package:safsofa/cubits/gify_cubit/gift_cubit.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:intl/intl.dart';

class CouponesScreen extends StatefulWidget {
  const CouponesScreen({Key? key}) : super(key: key);

  @override
  State<CouponesScreen> createState() => _CouponesScreenState();
}

class _CouponesScreenState extends State<CouponesScreen> {
  @override
  void initState() {
    GiftCubit.get(context).showCouponsData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'coupons'.tr(),
      ),
      body: BlocConsumer<GiftCubit, GiftState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          GiftCubit cubit = GiftCubit.get(context);
          return ConditionalBuilder(
            condition: state is! ShowCouponsDataLoading,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return
                  cubit.couponsModel!.data!.couponLists!.length==0 ?
                  Center(
                      child: Image(
                          image:
                          AssetImage('assets/images/empty_cart.png')))
                      :
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 8,
                    color: cubit.couponsModel!.data!.couponLists![index].status =='1'? Colors.white : Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,

                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '- ${cubit.couponsModel?.data?.couponLists![index].value}%',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    )),
                                /*    SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text("forOrdersMoreThan".tr(),
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                    Text("99,0 ${"rS".tr()}",
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),*/
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text("code".tr(),
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                    Text("${cubit.couponsModel?.data?.couponLists![index].coupon}",
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 8,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text('${cubit.couponsModel?.data?.couponLists![index].startDate} ~',
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text('${cubit.couponsModel?.data?.couponLists![index].endDate} ',
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                            /*    SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 8,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text('forSelectedItems'.tr(),
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),*/
                              ]),
                          cubit.couponsModel!.data!.couponLists![index].status !='1'?
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.black,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2),
                              child: Text(
                                'expired'.tr(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ):SizedBox(),

                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              itemCount: cubit.couponsModel!.data!.couponLists!.length,
            ),
            fallback: (context) => Center(child: RefreshProgressIndicator()),
          );
        },
      ),
    );
  }
}
