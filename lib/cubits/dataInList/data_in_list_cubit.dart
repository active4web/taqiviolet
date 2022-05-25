import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/datainlist.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_Mhelper.dart';
import '../../shared/constants.dart';
part 'data_in_list_state.dart';

class DataInListCubit extends Cubit<DataInListState> {
  DataInListCubit() : super(DataInListInitial());

 int   roster_id;
  static DataInListCubit get(context) => BlocProvider.of(context);
  DataInListModel dataInList;
  void postlistsData( {String id}) {
    emit(DataInListLoadingState());


    Mhelper.postData(token: CacheHelper.getData("token"),
        url:  roster_idURL,data: {
          "roster_id":id
        }
    ).then((value) {
      dataInList=DataInListModel.fromJson(value.data);

      emit(DataInListSuccessState());
    }).catchError(
            (error) {
          emit(DataInListErrorState());
          print(error.toString());
        }
    );



  }


  void postdeletItemlistsData( {String id}) {
    emit(DataInListLoadingState());


    Mhelper.postData(token: CacheHelper.getData("token"),
        url:  deleteRosterItemURL,data: {
          "id":id
        }
    ).then((value) {


      postlistsData(id: roster_id.toString());
     //  dataInList=DataInListModel.fromJson(value.data);
//  postlistsData(id:id );
print(value.data);
    emit(DataInListSuccessState());
    }).catchError(
            (error) {
        emit(DataInListErrorState());
          print(error.toString());
        }
    );



  }


}
