import 'dart:developer';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:safsofa/shared/constants.dart';
import '../../cubits/contactsCubit/contacts_cubit.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsCubit, ContactsState>(
      builder: (context, state) {
        ContactsCubit cubit = ContactsCubit.get(context);
        state is ContactsInitial
            ? cubit.getTermsAndConditions()
            : log("getdata");

        return Scaffold(
          appBar: CustomAppBar(
            title: 'TermsAndConditions'.tr(),
          ),
          body: state is! ContactsStateSuccessState
              ? Center(
                  child: CircularProgressIndicator(
                  color: kDarkGoldColor,
                ))
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Label(
                        text: 'TermsAndConditions'.tr(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, pos) {
                              return Text(
                                  "${cubit.termsAndConditions.data![pos].txtName}");
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount: cubit.termsAndConditions.data!.length),
                      ),

                      // SizedBox(
                      //   height: 30,
                      // ),
                      // Label(
                      //   text: 'TermsAndConditions'.tr(),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(kLoremIpsum),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // Label(
                      //   text: 'TermsAndConditions'.tr(),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(kLoremIpsum),
                      // SizedBox(
                      //   height: 30,
                      // ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
