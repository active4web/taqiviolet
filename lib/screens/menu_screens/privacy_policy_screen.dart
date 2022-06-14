import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';

import '../../cubits/SuccessStoriesCubit/privacy_policy_cubit.dart';
import '../../cubits/SuccessStoriesCubit/privacy_policy_state.dart';
import '../../shared/constants.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrivacyPolicyCubit, PrivacyPolicyState>(
      listener: (context, state) {
        // print(PrivacyPolicyCubit.get(context).storeListOfData.length);
      },
      builder: (context, state) {
        PrivacyPolicyCubit cubit = PrivacyPolicyCubit.get(context);
        state is PrivacyPolicyInitial
            ? cubit.getPrivacyPolicy()
            : print("mostafa");

        return Scaffold(
          appBar: CustomAppBar(
            title: 'privacy policy'.tr(),
          ),
          body: state is! GetPrivacyPolicySuccessState
              ? Center(
                  child: CircularProgressIndicator(
                  color: kDarkGoldColor,
                ))
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        print(
                            "imageeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
                        print(cubit.privacyPolicyModel.data[index].image);
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    cubit.privacyPolicyModel.data[index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: kDarkGoldColor),
                                  ),
                                ),
                              ],
                            ),
                            // Label(
                            //     text:
                            //         cubit.privacyPolicyModel.data[index].title),
                            SizedBox(
                              height: 10,
                            ),
                            // Container(
                            //     decoration: BoxDecoration(
                            //       color: Colors.grey.shade400,
                            //     ),
                            //     child: Image.network(
                            //         cubit.privacyPolicyModel.data[index].image)),
                            SizedBox(
                              height: 10,
                            ),
                            // Row(
                            //   children: [
                            //     Text(
                            //       cubit.storeListOfData[index].iD.toString(),
                            //       style: TextStyle(color: Colors.grey),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              cubit.privacyPolicyModel.data[index].content,
                              style: TextStyle(fontSize: 15, height: 2),
                            ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // GridView.builder(
                            //   shrinkWrap: true,
                            //   physics: NeverScrollableScrollPhysics(),
                            //   gridDelegate:
                            //       SliverGridDelegateWithFixedCrossAxisCount(
                            //           crossAxisCount: 3,
                            //           crossAxisSpacing: 10,
                            //           mainAxisSpacing: 10,
                            //           childAspectRatio: 8 / 6),
                            //   itemBuilder: (context, i) => Container(
                            //     decoration: BoxDecoration(
                            //         color: Colors.grey.shade400,
                            //         image: DecorationImage(
                            //             image: NetworkImage(cubit
                            //                 .storeListOfData[index].image[i]))),
                            //   ),
                            //   itemCount:
                            //       cubit.storeListOfData[index].image.length,
                            // )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Divider(),
                          ),
                      itemCount: cubit.privacyPolicyModel.data.length - 2),
                ),
        );
      },
    );
  }
}
