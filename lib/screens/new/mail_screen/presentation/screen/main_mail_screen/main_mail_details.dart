import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/shared/constants.dart';
import '../../../../../../shared/components/custom_app_bar.dart';
import '../../../../personel_page/help/custom_circular_progress/custom_circular_progress.dart';
import '../../controller/mail_cubit.dart';
import '../../controller/mail_state.dart';
import '../../widgets/receiver.dart';
import '../../widgets/sender.dart';



class MainMailDetailsScreen extends StatefulWidget {
  final int id;
  MainMailDetailsScreen({Key? key,
  required this.id}) : super(key: key);

  @override
  State<MainMailDetailsScreen> createState() => _MainMailDetailsScreenState();
}

class _MainMailDetailsScreenState extends State<MainMailDetailsScreen> {
  final TextEditingController _messageController = TextEditingController();
@override
  void initState() {
    MailCubit.get(context)..getMessageDetails(id: widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<MailCubit, MailState>(
  listener: (context, state) {
    if(state is ReplayMessageSuccessState){
      MailCubit.get(context).messageController.clear();
    }
  },
  builder: (context, state) {
    var cubit=MailCubit.get(context);
    return Scaffold(
/*
      endDrawer: const CeoDrawer(),
*/
      appBar: CustomAppBar(
        title: cubit.messageDetails?.data?.title??'',
      ),
      body: ConditionalBuilder(condition: cubit.messageDetails!=null, builder: (context)=>Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1,color: Colors.grey.shade300)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(radius: 20,
                          child: Image.asset('assets/images/technical-support-chat.png',fit: BoxFit.fill,),),
                          SizedBox(width: 20,),
                          Text(cubit.messageDetails?.data?.senderName??''),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(cubit.messageDetails?.data?.content??''),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
              ConditionalBuilder(
                  condition: true,
                  builder: (context)=>Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
/*                  var message = cubit.messages[index];*/
                        // if (true) {
                        //   return Padding(
                        //     padding:  EdgeInsets.symmetric(horizontal: 8),
                        //     child:  Sender(
                        //       containerColor: kCustomBlack,
                        //       messageOwner: "انا",
                        //       alignment:  AlignmentDirectional.centerStart,
                        //       senderMessage: 'dfgaddddddddddddg',
                        //       /*      model: message,*/
                        //     ),
                        //   );
                        // }
                        // return  Padding(
                        //   padding:  EdgeInsets.symmetric(horizontal: 8),
                        //   child: Sender(
                        //     containerColor: Colors.grey.shade400,
                        //     messageOwner: 'ahmed',
                        //
                        //     alignment: AlignmentDirectional.centerEnd,
                        //     senderMessage: 'hhhhhaaaaaaaaaaaaaaaaah',
                        //     /*      model: message,*/
                        //   ),
                        // );
                       return Column(
                         children: [
                         Padding(
                           padding:  EdgeInsets.symmetric(horizontal: 8),
                           child: Sender(
                             containerColor:cubit.messageDetails?.data?.emails?[index].senderId==cubit.messageDetails?.data?.emails?[index].authId?kCustomBlack: Colors.grey.shade400,
                             messageOwner:cubit.messageDetails?.data?.emails?[index].senderId==cubit.messageDetails?.data?.emails?[index].authId? "انا":cubit.messageDetails?.data?.senderName??'',
                             textColor:cubit.messageDetails?.data?.emails?[index].senderId==cubit.messageDetails?.data?.emails?[index].authId? Colors.white:Colors.black,
                             alignment:cubit.messageDetails?.data?.emails?[index].senderId==cubit.messageDetails?.data?.emails?[index].authId?AlignmentDirectional.centerStart :AlignmentDirectional.centerEnd,
                             senderMessage: cubit.messageDetails?.data?.emails?[index].content??'',
                             /*      model: message,*/
                           ),
                         ),

                         ],
                       );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(
                            height: 10.h,
                          ),
                      itemCount: cubit.messageDetails?.data?.emails?.length??0
                    ),
                  ),
                  fallback: (context)=>Center(
                    child: Text('empty'),

                  )),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xff393939),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      topLeft: Radius.circular(10.r),
                    )),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    MaterialButton(
                      minWidth: 1.0,
                      height: 50.h,
                      onPressed: () {
                        if(cubit.messageFormKey.currentState!.validate()){
                          cubit.replayMessage(id: widget.id);
                        }
                      },
                      child:Transform.rotate(angle: 180 * 3.1 / 180,child: Icon(Icons.send,color: Colors.white,size: 30,))
                      // Image.asset('assets/images/download.png',height: 30,),
                    ),
                    Form(
                      key: cubit.messageFormKey,
                      child: Expanded(
                        child: Container(
                          height: 40.h,
                          child: TextFormField(
                            controller: cubit.messageController,
                            style: const TextStyle(
                                color: Colors.white
                            ),
                            validator: (value){
                              if(value!.trim().isEmpty){
                                return 'يجب ان لا يكون الرسالة فارغه';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "اكتب رساله",

                              hintStyle: TextStyle(
                                  color: Colors.white
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.r),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.r),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.r),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                            ),
                            keyboardAppearance: Brightness.dark,
                          ),
                        ),
                      ),
                    ),
                    // IconButton(onPressed: () {},
                    //     icon: Icon(Icons.camera_alt, color: Colors.white,))
                  ],
                ),
              ),

            ],
          ), fallback: (context)=>Center(child: CustomCircularProgress()))

    );
  },
);
  }
}
