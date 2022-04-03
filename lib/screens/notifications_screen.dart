import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/appCubit/app_states.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/constants.dart';

import 'bottom_navigation_screens/my_account_screen.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kToken == null
        ? MoveToLoginScreen()
        : Scaffold(
            appBar: CustomAppBar(
              title: 'Notifications'.tr(),
            ),
            body: BlocBuilder<AppCubit, AppStates>(
              builder: (context, state) {
                AppCubit cubit = AppCubit.get(context);
                return cubit.notificationsListModel == null
                    ? CircularProgressIndicator(
                  color: Colors.black,
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
                                    onPressed: () {},
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              cubit.notificationsListModel.result
                                          .allNotifications.length ==
                                      0
                                  ? Text("لا يوجد اشعارات").tr()
                                  : ListView.separated(
                                      itemCount: cubit.notificationsListModel
                                          .result.allNotifications.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) => ListTile(
                                        leading: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Color(0xfff5f5f5),
                                              image: DecorationImage(
                                                  image: NetworkImage(cubit
                                                      .notificationsListModel
                                                      .result
                                                      .allNotifications[index]
                                                      .img)),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        ),
                                        title: Text(cubit
                                            .notificationsListModel
                                            .result
                                            .allNotifications[index]
                                            .title),
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(cubit
                                              .notificationsListModel
                                              .result
                                              .allNotifications[index]
                                              .createdAt
                                              .toString()
                                              .substring(0, 10)),
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
