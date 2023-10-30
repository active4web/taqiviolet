import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/screens/new/mail_screen/models/message_details_model.dart';
import 'package:safsofa/screens/new/mail_screen/models/message_model.dart';
import 'package:safsofa/screens/new/mail_screen/models/search_phone_model.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast_states.dart';
import '../../../../../network/local/cache_helper.dart';
import 'mail_state.dart';



class MailCubit extends Cubit<MailState> {
  MailCubit() : super(MailInitial());

  static MailCubit get(context)=>BlocProvider.of(context);


var phoneController=TextEditingController();
var messageController=TextEditingController();
var titleController=TextEditingController();
var formKey=GlobalKey<FormState>();
var messageFormKey=GlobalKey<FormState>();
  TabController? tabController;

  MessageModel?inboxModel;
  MessageModel?outboxModel;
  SearchPhoneModel? searchPhoneModel;
  Future<void> searchPhone({required String Phone})async{
   final response=await Mhelper.getData(url: 'api/phone-search',token: CacheHelper.getData("token"),query: {
      "phone":Phone
    });
   if(response.data['status']){
     searchPhoneModel=SearchPhoneModel.fromJson(response.data);
     emit(GetPhoneOwnerSuccessState(name: 'name'));
  }}
Future<void> sendMail()async {
  emit(SendEmailLoadingState());
  final response = await Mhelper.postData(url: 'api/chat/emails',
      token: CacheHelper.getData("token"),
      data: {
        "title": titleController.text,
        "phone": phoneController.text,
        "content": messageController.text,
      });

  if (response.data['status']) {
    // if(response.data['success']==false){
    //   emit(SendEmailSuccessWithExceptionState(message: response.data['data']));
    // }else{
    //   emit(SendEmailSuccessState());
    // }
    emit(SendEmailSuccessState());
    getInbox();
    getOutbox();
    tabController?.index=0;
    phoneController.clear();
    titleController.clear();
    messageController.clear();
    searchPhoneModel=null;
  } else {

    emit(SendEmailErrorState(error: response.data['message']));
  }
}

  Future<void> replayMessage({required int id})async {
    emit(ReplayMessageLoadingState());
    final response = await Mhelper.postData(url: 'api/chat/emails',
        token: CacheHelper.getData("token"),
        data: {
          "parent_id":id,
          "content": messageController.text,
        });

    if (response.data['status']) {
      // if(response.data['success']==false){
      //   emit(SendEmailSuccessWithExceptionState(message: response.data['data']));
      // }else{
      //   emit(SendEmailSuccessState());
      // }
      emit(ReplayMessageSuccessState());
      getMessageDetails(id: id);
    } else {

      emit(ReplayMessageErrorState());
    }
  }

Future<void>getInbox()async{
    emit(GetInboxLoadingState());
    final response=await Mhelper.getData(url: 'api/chat/emails/inbox',token: CacheHelper.getData('token'));
    if(response.data['status']){
      inboxModel=MessageModel.fromJson(response.data);
      emit(GetInboxSuccessState());
    }else{
      emit(GetInboxErrorState());
    }
}
  Future<void>getOutbox()async{
    emit(GetOutboxLoadingState());
    final response=await Mhelper.getData(url: 'api/chat/emails/outbox',token: CacheHelper.getData('token'));
    if(response.data['status']){
      outboxModel=MessageModel.fromJson(response.data);
      emit(GetOutboxSuccessState());
    }else{
      emit(GetOutboxErrorState());
    }
  }

  MessageDetailsModel?messageDetails;
  Future<void>getMessageDetails({required int id})async{
    messageDetails=null;
    emit(GetMessageDetailsLoadingState());
    final response=await Mhelper.getData(url: 'api/chat/emails/${id}',token: CacheHelper.getData('token'));
    if(response.data['status']){
      messageDetails=MessageDetailsModel.fromJson(response.data);
      print(response.data);
      getOutbox();
      getInbox();
      emit(GetMessageDetailsSuccessState());
    }else{
      emit(GetMessageDetailsErrorState());
    }

  }
//
// String? ownerName;
//
//   Future<void> getPhoneOwnerName()async{
//     emit(GetPhoneOwnerLoadingState());
//     final response=await DioHelper.postData(url: "/api/get-name-by-phone",
//         token: AppConstance.token,
//         data: {
//           "phone":phoneController.text,
//         });
//
//     if(response.statusCode==200){
//       if(response.data['success']==false){
//         emit(GetPhoneOwnerSuccessWithExceptionState(message: response.data['message']));
//       }else{
//         ownerName=response.data["data"]["name"];
//         emit(GetPhoneOwnerSuccessState(name: response.data["data"]["name"]));
//       }
//
//     }else{
//       emit(GetPhoneOwnerErrorState(error:response.data['message']));
//     }
//   }
//
// void deleteAllData(){
//   titleController.text='';
//   messageController.text='';
//   phoneController.text='';
//   ownerName=null;
// }
}
