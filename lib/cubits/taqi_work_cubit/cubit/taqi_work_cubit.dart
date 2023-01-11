import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/taqi_work_cubit/cubit/taqi_work_state.dart';
import 'package:safsofa/cubits/tqi_work_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:safsofa/shared/defaults.dart';

class TaqiWorkCubit extends Cubit<TaqiWorkState> {
  TaqiWorkCubit() : super(TaqiWorkCubitInitial());
  static TaqiWorkCubit get(context) => BlocProvider.of(context);
  TqiWorkModel workModel;
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

  PlatformFile file;
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
    @required String name,
    @required String email,
    @required String phone,
    @required String comment,
  }) async {
    emit(SendingLoadingState());
    Mhelper.postData(url: '/api/ideas_taqiviolet', data: {
      'name': name,
      'phone': phone,
      'message': comment,
      'email': email,
      'file': await MultipartFile.fromFile(file.path, filename: file.name),
    }).then((value) {
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
}
