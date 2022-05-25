import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_button.dart';
import 'package:safsofa/shared/components/custom_form_field.dart';
import 'package:safsofa/shared/components/custom_label.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/cubit/getdataprofile_cubit.dart';
import '../models/register_success_model.dart';
import '../network/local/cache_helper.dart';

class MyProfileScreen extends StatelessWidget {
    MyProfileScreen({Key key}) : super(key: key);
TextEditingController  name=TextEditingController();
    TextEditingController  email=TextEditingController();
    TextEditingController  phone=TextEditingController();
    TextEditingController  address=TextEditingController();

  @override
  Widget build(BuildContext context) {
    GetdataprofileCubit cubit = GetdataprofileCubit.get(context);
    if( cubit.state is GetdataprofileInitial){
      cubit.getdataprofileCData();
    }


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'MyProfile'.tr(),
      ),
      body: BlocBuilder<GetdataprofileCubit, GetdataprofileState>(
        builder: (context, state) {

  if(state is GetdataprofileInitialSuccessState){
  name.text=cubit.getdataprofileModel.name;
  email.text=cubit.getdataprofileModel.email;
  phone.text=cubit.getdataprofileModel.phone;
  address.text=cubit.getdataprofileModel.address;
  return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Label(
              text: 'FullName'.tr(),
            ),
            SizedBox(
              height: 10,
            ),
            CustomFormField(controller: name),
            SizedBox(
              height: 20,
            ),
            Label(
              text: 'Email'.tr(),
            ),
            SizedBox(
              height: 10,
            ),
            CustomFormField(controller: email),
            SizedBox(
              height: 20,
            ),
            Label(
              text: 'Phone'.tr(),
            ),
            SizedBox(
              height: 10,
            ),
            CustomFormField(controller: phone),
            SizedBox(
              height: 20,
            ),
            Label(
              text: 'Address'.tr(),
            ),
            SizedBox(
              height: 10,
            ),
            CustomFormField(controller: address),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
            ),
            state is postdataprofileLoadingState?CircularProgressIndicator():    CustomButton(onTap: (){
              CacheHelper.getData(  'id');
              CacheHelper.getData(  'token');
cubit.postDataProfile(id: CacheHelper.getData(  'id'),name: name.text,address: address.text,email:email.text ,phone:phone.text );





            },
              height: 50,
              text: 'Save'.tr(),
            )
          ],
        ),
      ),
    );
}else{
  return Center(child: CircularProgressIndicator(),);
}
 }),
    );
  }
}
