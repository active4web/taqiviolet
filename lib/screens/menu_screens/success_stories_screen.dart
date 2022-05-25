import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/SuccessStoriesCubit/success_stories_cubit.dart';
import '../../cubits/SuccessStoriesCubit/success_stories_state.dart';

class SuccessStoriesScreen extends StatelessWidget {
  const SuccessStoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SuccessStoriesCubit, SuccessState>(
      listener: (context, state) {
        print(SuccessStoriesCubit.get(context).storeListOfData.length);
      },
      builder: (context, state) {
        SuccessStoriesCubit cubit = SuccessStoriesCubit.get(context);
        state is SuccessInitial ? cubit.getSuccessStories() : print("mostafa");

        return Scaffold(
          appBar: CustomAppBar(
            title: 'SuccessStories'.tr(),
          ),
          body: state is! GetSuccessSuccessState
              ? Center(
                  child: Text("the data is Uploading......"),
                )
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        print(
                            "imageeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
                        print(cubit.storeListOfData[index].image);
                        return Column(
                          children: [
                            Label(text: cubit.storeListOfData[index].title),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                ),
                                child: Image.network(
                                    cubit.storeListOfData[index].image[0])),
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
                              cubit.storeListOfData[index].content,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 8 / 6),
                              itemBuilder: (context, i) => Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    image: DecorationImage(
                                       image: NetworkImage( cubit.storeListOfData[index].image[i]))
                                        ),
                              ),
                              itemCount:
                                  cubit.storeListOfData[index].image.length,
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Divider(),
                          ),
                      itemCount: cubit.storeListOfData.length),
                ),
        );
      },
    );
  }
}
