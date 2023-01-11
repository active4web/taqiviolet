import 'dart:developer';

import '../../models/details_support_model.dart';
import '../../network/remote/dio_Mhelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/technicalSupporDetailstCubit/technical_suppor_detailst_state.dart';

import '../../shared/constants.dart';

class TechnicalSupportDetailsCubit
    extends Cubit<TechnicalSupportDetailstState> {
  TechnicalSupportDetailsCubit() : super(TechnicalSupportdetailstInitial());

  static TechnicalSupportDetailsCubit get(context) => BlocProvider.of(context);
  int id;

  ///Get Data From stories
  DetailsSupportModel detailsSupportModel;
  List<DetailsSupportData> detailsSupportDetailsData;

  void getTechnicalSupport() async {
    emit(GetTechnicalSupportdetailstLoadingState());
    log('${dataFromalldetailsSupport + id.toString()}');
    await Mhelper.postData(url: dataFromalldetailsSupport + id.toString())
        .then((value) async {
      log("0" * 50);
      log(value.data.toString());
      log("0" * 50);
      detailsSupportModel = DetailsSupportModel.fromJson(value.data);
      detailsSupportDetailsData = detailsSupportModel.data;

      emit(GetTechnicalSupportdetailstSuccessState());
    }).catchError((err) {
      log("Error form dio:$err");
      emit(GetTechnicalSupportdetailstErrorState());
    });
  }
}
