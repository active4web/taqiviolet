import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';

import '../../models/inventory/inventory_model.dart';
import '../../network/local/cache_helper.dart';
import '../../shared/constants.dart';
part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  InventoryCubit() : super(InventoryInitial());

  static  InventoryCubit get(context)=>BlocProvider.of(context);

InventoryModel? inventoryModel;
  getInventoryList(){
    emit(GetListInventoryLoading());
    Mhelper.getData(url: '/api/liststore',token: CacheHelper.getData('token'),query: {
      'lang':kLanguage
    }).then((value) {
      print('*********data**********${value.data}');

      inventoryModel=InventoryModel.fromJson(value.data);
      emit(GetListInventorySuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetListInventoryError());
    });
  }
}
