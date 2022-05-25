import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/lists_model.dart';
import '../../models/my_product_details_model.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_Mhelper.dart';
import '../../shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dataInList/data_in_list_cubit.dart';
part 'lists_state.dart';

class ListsCubit extends Cubit<ListsState> {
  ListsCubit() : super(ListsInitial());
  static ListsCubit get(context) => BlocProvider.of(context);
  ListsModel listsModel;


  MYProductDetailsModel productDetailsModel;




  void getlistsData( ) {
    emit(ListsLoadingState());


    Mhelper.getData(token: CacheHelper.getData("token"),
      UrlPath: mainListURL,
    ).then((value) {

      listsModel = ListsModel.fromJson(value.data);
       print(listsModel.toJson());
      // allOffer=offerModel.data;
      // print("${allOffer}");
      emit(ListsSuccessState());
    }).catchError(
            (error) {
          emit(ListsErrorState());
          print(error.toString());
        }
    );



  }
  void postlistsData( {String listName}) {
   emit(ListsLoadingState());


    Mhelper.postData(token: CacheHelper.getData("token"),
      url:  createRosterURL,data: {
          "name":listName
        }
    ).then((value) {
      getlistsData( );

      emit(ListsSuccessState());
    }).catchError(
            (error) {
          emit(ListsErrorState());
          print(error.toString());
        }
    );



  }


  void deleteRosterlistsData( {String id}) {
    emit(ListsLoadingState());


    Mhelper.postData(token: CacheHelper.getData("token"),
        url:  deleteRosterURL,data: {
          "id":id
        }
    ).then((value) {
      getlistsData( );

      emit(ListsSuccessState());
    }).catchError(
            (error) {
          emit(ListsErrorState());
          print(error.toString());
        }
    );



  }



  void addItemToList({String id,context}){
   emit(ListsLoadingState());

print("adddddddd datatatatat to lissssssssssssssn  product_id ${productDetailsModel.data.productDetails[0].id}     roster_id $id");
    Mhelper.postData(token: CacheHelper.getData("token"),
        url:  addToRosterItemURL,data: {
          "product_id":productDetailsModel.data.productDetails[0].id.toString(), "roster_id":id
        }
    ).then((value) {
      print("*"*20);
      print(value.data);

      print("*"*20);
       //getlistsData( );
      DataInListCubit.get(context).postlistsData(id:id );
      productDetailsModel==null;
  emit(ListsSuccessState());
    }).catchError(
            (error) {
          emit(ListsErrorState());
          print(error.toString());
        }
    );

  }
}
