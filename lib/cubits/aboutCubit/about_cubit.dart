import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/aboutCubit/about_state.dart';
import 'package:safsofa/models/about_model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';

class AboutCubit extends Cubit<AboutStates> {
  AboutCubit() : super(AboutInitial());

  static AboutCubit get(context) => BlocProvider.of(context);

  ///Get Data From stories
  AboutModel? aboutModel;
  List<AboutModelData>? aboutData;

  void getAbout() async {
    log("i get the lang     ${CacheHelper.getData("language")}");
    emit(GetAboutLoadingState());
    await Mhelper.getData(
      url: dataFromabout,
      query: {
        'lang': kLanguage,
      },
      token: kToken,
    ).then((value) async {
      log("0" * 50);
      log(value.data.toString());
      log("0" * 50);
      aboutModel = AboutModel.fromJson(value.data);
      aboutData = aboutModel?.data!;
      log(value.data.toString());
      log(aboutData![0].title.toString());
      emit(GetAboutSuccessState());
    }).catchError((err) {
      log("Error form dio:$err");
      emit(GetAboutErrorState());
    });
  }
}