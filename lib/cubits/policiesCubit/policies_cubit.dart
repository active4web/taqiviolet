import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:safsofa/models/privacy_policy_details_model.dart';
import 'package:safsofa/models/privacy_policy_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

part 'policies_state.dart';

class PoliciesCubit extends Cubit<PoliciesState> {
  PoliciesCubit() : super(PoliciesInitial());

  static PoliciesCubit get(context) => BlocProvider.of(context);

  //Get Blog Data
  // BlogModel blog;
  // List<Blogs> blogs;
  // List<LastBlogs> lastblog;
  PrivacyPolicyModel? _privacyPolicyModel;
  List<PrivacyPolicyData>? policies = [];
  void getPoliciesData() async {
    policies?.clear();
    emit(GetPoliciesLoadingState());
    await Mhelper.getData(
        url: dataFromPrivacyPolicy,
        query: {'lang': kLanguage}).then((value) async {
      log(value.data.toString());
      _privacyPolicyModel = PrivacyPolicyModel.fromJson(value.data);
      // _privacyPolicyModel.data.forEach((element) {
      //   if (element.id > 17 && element.id <= 19) {
      //     policies.add(element);
      //     log("Data of policy:${policies[0].title}");
      //   }
      // }
      // );
      policies = _privacyPolicyModel?.data;
      // log('$blogs');
      emit(GetPoliciesSuccessState());
    }).catchError((err) {
      log("ERR:$err");
      emit(GetPoliciesErrorState());
    });
  }

  PrivacyPolicyDetailsModel? policyDetails;
  void getPolicyDetails({required int id}) {
    emit(GetPolicyDetailsLoadingState());
    Mhelper.getData(url: privacyPolicyDetailsUrl, token: kToken, query: {
      'lang': kLanguage,
      'id': '$id',
    }).then((value) {
      policyDetails = PrivacyPolicyDetailsModel.fromJson(value.data);
      log(policyDetails!.data.toString());
      emit(GetPolicyDetailsSuccessState());
    }).catchError((error) {
      log('Error on policy details: ${error.toString()}');
      emit(GetPolicyDetailsErrorState());
    });
  }
}
