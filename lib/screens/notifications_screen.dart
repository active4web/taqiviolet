import 'dart:developer';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/screens/register_screens/login_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/constants.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    cubit.getAllNotifications();

    return kToken == null
        ? LoginScreen()
        : Scaffold(
            appBar: CustomAppBar(
              title: 'Notifications'.tr(),
            ),
            body: BlocBuilder<AppCubit, AppStates>(
              builder: (context, state) {
                log('$state');

                return state is GetAllNotificationsLoadingState
                    ?

                    //  cubit.notificationsListModel == null
                    Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(22),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  TextButton(
                                    child: Text(
                                      'DeleteAll'.tr(),
                                      style:
                                          TextStyle(color: Color(0xffD0021B)),
                                    ),
                                    onPressed: () {
                                      cubit.delAllNotifications();
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              cubit.notificationsListModel.data.length == 0
                                  ? Text("لا يوجد اشعارات").tr()
                                  : ListView.separated(
                                      itemCount: cubit
                                          .notificationsListModel.data.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) => InkWell(
                                        onLongPress: () {
                                          cubit.deloneNotifications(cubit
                                              .notificationsListModel
                                              .data[index]
                                              .id);
                                        },
                                        child: ListTile(
                                          // leading: Container(
                                          //   height: 50,
                                          //   width: 50,
                                          //   decoration: BoxDecoration(
                                          //       color: Color(0xfff5f5f5),
                                          //       image: DecorationImage(
                                          //           image: NetworkImage(cubit
                                          //               .notificationsListModel
                                          //               .data
                                          //              [index]
                                          //               .img)),
                                          //       borderRadius:
                                          //           BorderRadius.circular(50)),
                                          // ),
                                          title: Text(cubit
                                              .notificationsListModel
                                              .data[index]
                                              .title),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(cubit
                                                .notificationsListModel
                                                .data[index]
                                                .createdAt
                                                .toString()
                                                .substring(0, 10)),
                                          ),
                                        ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          Divider(),
                                    )
                            ],
                          ),
                        ),
                      );
              },
            ),
          );
  }
}
