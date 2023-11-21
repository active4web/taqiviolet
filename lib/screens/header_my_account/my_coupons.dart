import 'package:flutter/material.dart%20';
import 'package:safsofa/cubits/gify_cubit/gift_cubit.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCouponsScreen extends StatelessWidget {
  const MyCouponsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // Added
      length: 2, // Added
      initialIndex: 0, //Added
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'wallet'.tr(),
        ),
        body: BlocConsumer<GiftCubit, GiftState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Column(
              children: [
                TabBar(onTap: (index) {}, tabs: [
                  Tab(
                    child: Text("unusedCoupons".tr(),
                        style: TextStyle(color: Colors.black)),
                    // text: "all",
                  ),
                  Tab(
                    child: Text("expiredCoupons".tr(),
                        style: TextStyle(color: Colors.black)),
                    // text: "all",
                  ),
                ]),
                Expanded(
                  child:
                      TabBarView(physics: BouncingScrollPhysics(), children: [
                         ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, pos) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('- 25.00%',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      SizedBox(
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
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text("code".tr(),
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                          Text(" 232323",
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: 8,
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text('18:22 ',
                                              style: TextStyle(fontSize: 16)),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text('2023/02/20 ~',
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text('2023/02/20 ',
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: 8,
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text('yourLetter'.tr(),
                                              style: TextStyle(fontSize: 16)),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Expanded(
                                            child: Text(' احمد ',
                                                style: TextStyle(fontSize: 16)),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            ),
                          );
                        }),
                         ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (context, pos) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.grey[300],
                              elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('- 25.00%',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              )),
                                          SizedBox(
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
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text("code".tr(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  )),
                                              Text(" 232323",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                size: 8,
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text('18:22 ',
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text('2023/02/20 ~',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  )),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text('2023/02/20 ',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                size: 8,
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text('forSelectedItems'.tr(),
                                                  style:
                                                      TextStyle(fontSize: 16)),

                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                size: 8,
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text('yourLetter'.tr(),
                                                  style: TextStyle(fontSize: 16)),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Expanded(
                                                child: Text(' احمد ',
                                                    style: TextStyle(fontSize: 16)),
                                              ),
                                            ],
                                          ),
                                        ]),
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ]),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
