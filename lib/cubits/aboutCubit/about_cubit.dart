 
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/about_model.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_Mhelper.dart';
import '../../shared/constants.dart';
import 'about_state.dart';
class AboutCubit extends Cubit<AboutStates> {
  AboutCubit() : super(AboutInitial() );

  static AboutCubit get(context) => BlocProvider.of(context);

  ///Get Data From stories
  AboutModel aboutModel;
  List<AboutModelData> aboutData;

  void getAbout() async {
   print("i get the lang     ${ CacheHelper.getData("language")}");
    emit(GetAboutLoadingState());
    await Mhelper.getData(UrlPath: dataFromabout+(CacheHelper.getData("language")??"ar")).then((value) async {
      print("0"*50);
      print(value.data);
      print("0"*50);
      aboutModel = AboutModel.fromJson(value.data);
      aboutData = aboutModel.data;
      print(value.data);
      print(aboutData[0].txtName);
      emit(GetAboutSuccessState());
    }).catchError((err) {
      print("Error form dio:$err");
      emit(GetAboutErrorState());
    });
  }

}
