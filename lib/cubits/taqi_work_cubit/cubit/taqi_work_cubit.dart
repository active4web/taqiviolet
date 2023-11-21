import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/taqi_work_cubit/cubit/taqi_work_state.dart';
import 'package:safsofa/cubits/tqi_work_model.dart';
import 'package:safsofa/models/job_error_model.dart';
import 'package:safsofa/models/job_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast_states.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:safsofa/shared/defaults.dart';

class TaqiWorkCubit extends Cubit<TaqiWorkState> {
  TaqiWorkCubit() : super(TaqiWorkCubitInitial());
  static TaqiWorkCubit get(context) => BlocProvider.of(context);
  TqiWorkModel? workModel;
  void getTaqiWorkData() {
    emit(TaqiWorkCubitLoadingState());
    Mhelper.getData(url: '/api/companywork', token: kToken, query: {
      'lang': kLanguage,
    }).then((value) {
      workModel = TqiWorkModel.fromJson(value.data);
      log('${value.data}');
      emit(TaqiWorkCubitSuccessState());
    }).catchError((error) {
      log('Error on loading work with Taqi data:\n ${error.toString()}');
      emit(TaqiWorkCubitErrorState());
    });
  }

  PlatformFile? file;
  void pickMediaFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );
    if (result == null)
      return;
    else {
      file = result.files.first;
      emit(FilePickedSuccessfullyState());
    }
  }

  void removePickedFile() {
    file = null;
    emit(FileRemovedSuccessfullyState());
  }

  var formKey = GlobalKey<FormState>();
  void sendIdeaOfWork({
    required String name,
    required String email,
    required String phone,
    required String comment,
  }) async {
    emit(SendingLoadingState());
    Mhelper.postData(url: '/api/ideas_taqiviolet', data: FormData.fromMap({
      'name': name,
      'phone': phone,
      'message': comment,
      'email': email,
      'file': await MultipartFile.fromFile("${file?.path}", filename: file?.name),
    })).then((value) {
      log(value.data.toString());
      if (value.data['status']) {
        removePickedFile();
        showToast(
            text: "yourIdeaHasBeenSubmittedSuccessfully".tr(),
            color: Colors.green);
        emit(SendingSuccessState(value.data['status']));
      }
    }).catchError((error) {
      log('Error on sending ideas ${error.toString()}');
      emit(SendingErrorState());
    });
  }

  var email=TextEditingController();
  var name=TextEditingController();
  var phone=TextEditingController();
  JobModel? jobModel;
  Future<void> getJobs()async{
    emit(GetJobsLoadingState());
    final response=await Mhelper.getData(url: 'api/jobs',query: {
      'lang': kLanguage,
    });
    if(response.data['status']){
      jobModel=JobModel.fromJson(response.data);
      emit(GetJobsSuccessState());
    }else{
      emit(GetJobsErrorState());
    }
  }

  JobErrorModel? jobErrorModel;
  Future<void>applyJob({required int id})async{
    emit(ApplyJobLoadingState());
    final response=await Mhelper.postData(url: 'api/jobs/$id',data:FormData.fromMap( {
      "name":name.text,
      "email":email.text,
      "phone":phone.text,
      "cv":file==null?null:await MultipartFile.fromFile("${file?.path}", filename: file?.name)
    }));
    if(response.data['status']){
      emit(ApplyJobSuccessState());
      ToastConfig.showToast(msg: response.data['message'], toastStates: ToastStates.success);
    }else{
      emit(ApplyJobErrorState());
      jobErrorModel=JobErrorModel.fromJson(response.data);
      formKey.currentState?.validate();
    }
  }
}
