import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/models/list_request_model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';

part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  RequestCubit() : super(RequestInitial());

  static RequestCubit get(context)=>BlocProvider.of(context);

  ListRequestModel? listRequestModel;
  
  Future<void> getListRequest()async{
    print('token${CacheHelper.getData('token')}');
    emit(GetRequestLoadingState());
   final response=await Mhelper.getData(url: 'api/listrquest',
        query: {
     "lang":"ar"
        },
        token: CacheHelper.getData('token')
   );

   if(response.statusCode==200){
     listRequestModel=ListRequestModel.fromJson(response.data);
     print('iam heree');
     emit(GetRequestSuccessState());
   }else{
     print(response.data);
     print('error'*10);
     emit(GetRequestErrorState());
   }
  }
  }