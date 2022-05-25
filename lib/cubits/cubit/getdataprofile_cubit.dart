
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/get_data_profile_model.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_Mhelper.dart';
import '../../shared/constants.dart';
part 'getdataprofile_state.dart';

class GetdataprofileCubit extends Cubit<GetdataprofileState> {
  GetdataprofileCubit() : super(GetdataprofileInitial());
    GetdataprofileModel getdataprofileModel;



  static GetdataprofileCubit get(context) => BlocProvider.of(context);
  void getdataprofileCData( ) {
    emit(GetdataprofileInitialLoadingState());



    print("CacheHelper. ${CacheHelper.getData("token")}");
    Mhelper.getData(token: CacheHelper.getData("token"),
      UrlPath: userProfile,
    ).then((value) {

      getdataprofileModel = GetdataprofileModel.fromJson(value.data);
    //  print(getdataprofileModel.toJson());
      // allOffer=offerModel.data;
      // print("${allOffer}");
      emit(GetdataprofileInitialSuccessState());
    }).catchError(
            (error) {
          emit(GetdataprofileInitialErrorState());
          print(error.toString());
        }
    );



  }
void postDataProfile({phone,id,name,email,address}){

    Mhelper.postData(url: editProfile, data: {
      "phone": phone,
      "id": id,
      "name": name,
      "email": email,   "address": address,
    }).then((value) {

      getdataprofileCData( );

    });
}
  //CacheHelper.getData(  'id');
}
