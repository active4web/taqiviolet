
import 'package:bloc/bloc.dart';
import '../../models/details_support_model.dart';
import '../../network/remote/dio_Mhelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/technicalSupporDetailstCubit/technical_suppor_detailst_state.dart';

import '../../shared/constants.dart';

class TechnicalSupportDetailsCubit extends Cubit<TechnicalSupportDetailstState> {
  TechnicalSupportDetailsCubit() : super(TechnicalSupportdetailstInitial());

  static TechnicalSupportDetailsCubit get(context) => BlocProvider.of(context);
  int id;
  ///Get Data From stories
  DetailsSupportModel detailsSupportModel;
  List<DetailsSupportData>detailsSupportDetailsData;

  void getTechnicalSupport() async {


    emit(GetTechnicalSupportdetailstLoadingState());
print(dataFromalldetailsSupport + id.toString());
    await Mhelper.postData(url: dataFromalldetailsSupport + id.toString()).then((
        value) async {
      print("0" * 50);
      print(value.data);
      print("0" * 50);
      detailsSupportModel = DetailsSupportModel.fromJson(value.data);
      detailsSupportDetailsData = detailsSupportModel.data;


      emit(GetTechnicalSupportdetailstSuccessState());
    }).catchError((err) {
      print("Error form dio:$err");
      emit(GetTechnicalSupportdetailstErrorState());
    });
  }
}