import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';

import '../../models/get_data_profile_model.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_Mhelper.dart';
import '../../shared/constants.dart';
import 'package:dio/dio.dart';
part 'getdataprofile_state.dart';

class GetdataprofileCubit extends Cubit<GetdataprofileState> {
  GetdataprofileCubit() : super(GetdataprofileInitial());
  static GetdataprofileCubit get(context) => BlocProvider.of(context);

  GetdataprofileModel getdataprofileModel;
  void getdataprofileCData() {
    emit(GetdataprofileInitialLoadingState());

    log("CacheHelper. ${CacheHelper.getData("token")}");
    Mhelper.getData(
      token: CacheHelper.getData("token"),
      url: userProfile,
    ).then((value) {
      getdataprofileModel = GetdataprofileModel.fromJson(value.data['data']);
      //  print(getdataprofileModel.toJson());
      // allOffer=offerModel.data;
      // print("${allOffer}");
      log(value.data.toString());
      log('getdataprofileModel.image: ${getdataprofileModel.image}');
      emit(GetdataprofileInitialSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetdataprofileInitialErrorState());
    });
  }

  void postDataProfile({phone, id, name, email, address}) async {
    Mhelper.postData(url: editProfile, data: {
      "phone": phone,
      "id": id,
      "name": name,
      "email": email,
      "address": address,
      "image": await MultipartFile.fromFile(imageFile.path,
          filename: imageFile.name.split('/').last)
    }).then((value) {
      getdataprofileCData();
    });
  }

  XFile imageFile;

  void selectImage() async {
    final XFile selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      imageFile = selectedImage;
    }
    emit(GetdataprofileInitialSuccessState());
  }

  //CacheHelper.getData(  'id');
}
