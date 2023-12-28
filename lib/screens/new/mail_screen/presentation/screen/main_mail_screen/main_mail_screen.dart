import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safsofa/screens/new/mail_screen/presentation/controller/mail_cubit.dart';
import 'package:safsofa/screens/new/mail_screen/presentation/controller/mail_state.dart';
import 'package:safsofa/screens/new/mail_screen/presentation/screen/main_mail_screen/main_mail_details.dart';

import 'package:safsofa/screens/new/mail_screen/presentation/widgets/get_all_users.dart';
import 'package:safsofa/screens/new/personel_page/help/custom_circular_progress/custom_circular_progress.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../../shared/components/custom_app_bar.dart';
import '../../../../../../shared/components/custom_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainMailScreen extends StatefulWidget {
  MainMailScreen({Key? key}) : super(key: key);

  // TextEditingController controller = TextEditingController();

  @override
  State<MainMailScreen> createState() => _MainMailScreenState();
}

class _MainMailScreenState extends State<MainMailScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    MailCubit.get(context).tabController =
        TabController(length: 3, vsync: this);
    MailCubit.get(context)
      ..getInbox()
      ..getOutbox();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*
      endDrawer: const PmDrawer(),
*/
      appBar: CustomAppBar(
        title: "mailBox".tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<MailCubit, MailState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = MailCubit.get(context);
            return Column(
              children: [
                TabBar(controller: cubit.tabController, tabs: [
                  Tab(
                    text: "outbox".tr(),
                  ),
                  Tab(
                    text: "inbox".tr(),
                  ),
                  Tab(
                    text: "Send".tr(),
                  ),
                ]),
                Expanded(
                    child: TabBarView(
                  controller: cubit.tabController,
                  children: [
                    AnimatedConditionalBuilder(
                        condition: cubit.outboxModel?.data?.length==0,
                        builder: (context) => Center(
                              child: Text("No Messages"),
                            ),
                        fallback: (context) => AnimatedConditionalBuilder(
                            condition: state is GetOutboxLoadingState,
                            builder: (context) => CustomCircularProgress(),
                            fallback: (context) => ListView.separated(
                                itemBuilder: (context, index) => GetAllUsers(
                                    onTap: () {
                                      Navigator.push(
                                          (context),
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MainMailDetailsScreen(
                                                      id: cubit
                                                              .outboxModel
                                                              ?.data?[index]
                                                              .id ??
                                                          0)));
                                    },
                                    name: cubit.outboxModel?.data?[index]
                                            .reserverName ??
                                        '',
                                    message:
                                        cubit.outboxModel?.data?[index].title ??
                                            '',
                                    date: cubit.outboxModel?.data?[index]
                                            .createdAt ??
                                        '',
                                    color:cubit.outboxModel?.data?[index].senderReadAt==null?Colors.grey: Colors.grey.shade300),
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 10,
                                    ),
                                itemCount:
                                    cubit.outboxModel?.data?.length ?? 0))),
                    AnimatedConditionalBuilder(
                        condition: cubit.inboxModel?.data?.length==0,
                        builder: (context) => Center(
                          child: Text("No Messages"),
                        ),
                        fallback: (context) => AnimatedConditionalBuilder(
                            condition: state is GetInboxLoadingState,
                            builder: (context) => CustomCircularProgress(),
                            fallback: (context) => ListView.separated(
                                itemBuilder: (context, index) => GetAllUsers(
                                    onTap: () {
                                      Navigator.push(
                                          (context),
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MainMailDetailsScreen(
                                                      id: cubit.inboxModel
                                                          ?.data?[index].id ??
                                                          0)));
                                    },
                                    name:
                                    cubit.inboxModel?.data?[index].senderName ?? '',
                                    message: cubit.inboxModel?.data?[index].title ?? '',
                                    date: cubit.inboxModel?.data?[index].createdAt,
                                    color:cubit.inboxModel?.data?[index].reserverReadAt==null?Colors.grey: Colors.grey.shade300),
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                                itemCount: cubit.inboxModel?.data?.length ?? 0)))
                   ,
                    SingleChildScrollView(
                      child: Form(
                        key: cubit.formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),

                            CustomTextFormField(
                                check:
                                    cubit.searchPhoneModel?.data?.phone != null
                                        ? true
                                        : false,
                                textColor: Colors.black,
                                cursorColor: kCustomBlack,
                                onChanged: (value) {
                                  cubit.searchPhone(Phone: value);
                                },
                                controller: cubit.phoneController,
                                validate: (String? val) {
                                  if (val!.trim().isEmpty) {
                                    return 'يجب ادخال رقم المحمول';
                                  }
                                },
                                hintText: "Phone".tr(),
                                hintColor: Colors.black,
                                fillColor: Colors.grey.shade400,
                                keyboardType: TextInputType.phone),
                            if (cubit.searchPhoneModel?.data != null &&
                                cubit.searchPhoneModel?.data?.phone != null)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'المرسل اليه: ',
                                      style: TextStyle(
                                          color: kCustomBlack,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      cubit.searchPhoneModel?.data?.name ?? '',
                                      style: TextStyle(
                                          color: Colors.greenAccent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextFormField(
                                cursorColor: kCustomBlack,
                                textColor: Colors.black,
                                controller: cubit.titleController,
                                validate: (String? val) {
                                  if (val!.isEmpty) {
                                    return 'يجب ادخال عنوان الرساله';
                                  }
                                },
                                hintText: "title".tr(),
                                hintColor: Colors.black,
                                fillColor: Colors.grey.shade400,
                                keyboardType: TextInputType.emailAddress),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextFormField(
                              cursorColor: kCustomBlack,
                              textColor: Colors.black,
                              controller: cubit.messageController,
                              validate: (String? val) {
                                if (val!.isEmpty) {
                                  return 'يجب ادخال محتوى الرساله';
                                }
                              },
                              hintText: "message".tr(),
                              hintColor: Colors.black,
                              fillColor: Colors.grey.shade400,
                              keyboardType: TextInputType.emailAddress,
                              maxLines: 6,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                if (cubit.formKey.currentState!.validate()) {
                                  cubit.sendMail();
                                }
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.h),
                                      decoration: BoxDecoration(
                                          color: Color(0xff393846),
                                          borderRadius:
                                              BorderRadius.circular(35)),
                                      child: Center(
                                          child: state is SendEmailLoadingState
                                              ? CustomCircularProgress()
                                              : Text(
                                                  "Send".tr(),
                                                  style: TextStyle(
                                                      color: kDarkGoldColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // CustomButton(onTap: (){
                            //   if(cubit.formKey.currentState!.validate()){
                            //     cubit.sendMail();
                            //     tabController?.index=1;
                            //   }
                            // },text: "ارسال",)
                          ],
                        ),
                      ),
                    )
                  ],
                ))
              ],
            );
          },
        ),
      ),
      // AppConstance.token != null ?
      // BlocConsumer<MailCubit,MailState>(
      //   listener: (context,state){
      //     var cubit=MailCubit.get(context);
      //     if(state is SendEmailSuccessState){
      //       cubit.getAllNotifications();
      //       cubit.deleteAllData();
      //       showToast(text: "تم ارسال الميل بنجاح", state: ToastStates.success);
      //
      //     }
      //     if(state is SendEmailSuccessWithExceptionState){
      //       showToast(text: state.message, state: ToastStates.success);
      //     }
      //     if(state is GetPhoneOwnerSuccessWithExceptionState){
      //       showToast(text: state.message, state: ToastStates.success);
      //     }
      //     if(state is SendEmailErrorState){
      //       showToast(text: state.error, state: ToastStates.success);
      //     }
      //   },
      //   builder: (context,state){
      //     var cubit=MailCubit.get(context);
      //     return Column(
      //       children: [
      //         TabBar(
      //             controller: tabController,
      //             tabs: [
      //           Tab(text: "المرسله",),
      //           Tab(text: "رسائلي",),
      //           Tab(text: "ارسال",),
      //         ]),
      //         Expanded(child: TabBarView(
      //             controller: tabController,
      //
      //             children: [
      //               ConditionalBuilder(
      //                   condition: cubit.getAllNotificationsModel!=null,
      //                   builder: (context)=>ConditionalBuilder(
      //                       condition: cubit.getAllNotificationsModel!.data!.sent!.isNotEmpty,
      //                       builder: (context)=>Padding(
      //                         padding:  EdgeInsets.only(bottom: 30.r,top: 15.r),
      //                         child: ListView.separated(
      //                           physics: const BouncingScrollPhysics(),
      //                           itemBuilder: (context, index) => GetAllUsers(
      //                             onTap: (){
      //                               //ToDO : NAVIGATE  DRETAILS
      //                               navigatorTo(context, MainMailDetailsScreen(id: cubit.getAllNotificationsModel!.data!.sent![index].messageId!,));
      //                             },
      //
      //                             name: cubit.getAllNotificationsModel!.data!.sent![index].reciverName!,
      //                             message: cubit.getAllNotificationsModel!.data!.sent![index].title!,
      //                             color:cubit.getAllNotificationsModel!
      //                                 .data!.sent![index].status !=
      //                                 1
      //                                 ? AppColors.lightGreyColor
      //                                 : AppColors.whiteColor.withOpacity(0),
      //                             date:cubit.getAllNotificationsModel!.data!.sent![index].date!,
      //                           ),
      //                           separatorBuilder: (context, index) => const CustomMyDivider(),
      //                           itemCount:cubit.getAllNotificationsModel!.data!.sent!.length,
      //                         ),
      //                       ),
      //                       fallback: (context)=>Center(
      //                         child: Text('لا يوجد اي ايميلات بعد',
      //                           style: Theme.of(context).textTheme.headline3,
      //                         ),
      //                       )),
      //                   fallback: (context)=>CustomCircularProgress()),
      //           ConditionalBuilder(
      //               condition: cubit.getAllNotificationsModel!=null,
      //               builder: (context)=>ConditionalBuilder(
      //                   condition: cubit.getAllNotificationsModel!.data!.recives!.isNotEmpty,
      //                   builder: (context)=>Padding(
      //                     padding:  EdgeInsets.only(bottom: 30.r,top: 15.r),
      //                     child: ListView.separated(
      //                       physics: const BouncingScrollPhysics(),
      //                       itemBuilder: (context, index) => GetAllUsers(
      //                         onTap: (){
      //                           //ToDO : NAVIGATE  DRETAILS
      //                           navigatorTo(context, MainMailDetailsScreen(id: cubit.getAllNotificationsModel!.data!.recives![index].messageId!,));
      //                         },
      //
      //                         name: cubit.getAllNotificationsModel!.data!.recives![index].senderName!,
      //                         message: cubit.getAllNotificationsModel!.data!.recives![index].title!,
      //                         color:cubit.getAllNotificationsModel!
      //                             .data!.recives![index].status !=
      //                             1
      //                             ? AppColors.lightGreyColor
      //                             : AppColors.whiteColor.withOpacity(0),
      //                         date: cubit.getAllNotificationsModel!.data!.recives![index].date!,
      //                       ),
      //                       separatorBuilder: (context, index) => const CustomMyDivider(),
      //                       itemCount:cubit.getAllNotificationsModel!.data!.recives!.length,
      //                     ),
      //                   ),
      //                   fallback: (context)=>Center(
      //                     child: Text('لا يوجد اي ايميلات بعد',
      //                       style: Theme.of(context).textTheme.headline3,
      //                     ),
      //                   )),
      //               fallback: (context)=>CustomCircularProgress()),
      //           ConditionalBuilder(
      //               condition: state is! SendEmailLoadingState,
      //               builder: (context)=>Padding(
      //             padding: const EdgeInsets.all(14.0),
      //             child: SingleChildScrollView(
      //               child: Form(
      //                 key: cubit.formKey,
      //                 child: Column(
      //                   children: [
      //
      //                     Row(
      //                       children: [
      //                         Expanded(
      //                           child: CustomFormFieldComponent(
      //                               controller: cubit.phoneController,
      //                               onSubmit: (value){
      //                                 cubit.getPhoneOwnerName();
      //                               },
      //                               validator: (value){
      //                                 if(value!.trim().isEmpty){
      //                                   return AppStrings.vacationForm(context).toString();
      //                                 }
      //                                 return null;
      //                               },
      //                               label: "رقم المحمول",
      //                               keyboardType: TextInputType.phone),
      //                         ),
      //                         if(cubit.ownerName!=null)
      //                           Text("المرسل الية:${cubit.ownerName}",style: Theme.of(context).textTheme.headline3,)
      //                       ],
      //                     ),
      //                     SizedBox(height: 18.h,),
      //                     CustomFormFieldComponent(
      //                         controller: cubit.titleController,
      //                         validator: (value){
      //                           if(value!.trim().isEmpty){
      //                             return AppStrings.vacationForm(context).toString();
      //                           }
      //                           return null;
      //                         },
      //                         label: "العنوان",
      //                         keyboardType: TextInputType.text),
      //                     SizedBox(height: 18.h,),
      //                     CustomFormFieldComponent(
      //                         height: 65.h,
      //                         controller: cubit.messageController,
      //                         validator: (value){
      //                           if(value!.trim().isEmpty){
      //                             return AppStrings.vacationForm(context).toString();
      //                           }
      //                           return null;
      //                         },
      //                         label: "الرسالة",
      //                         keyboardType: TextInputType.text),
      //                     SizedBox(height: 18.h,),
      //                     CustomRedBottom(text:AppStrings.send(context).toString(),
      //                         textColor: Colors.white,
      //                         onTap: (){
      //                           if(cubit.formKey.currentState!.validate()){
      //                             cubit.sendMail();
      //                           }
      //                         })
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //               fallback:(context)=> Center(child: CustomCircularProgress())),
      //         ]))
      //       ],
      //     );
      //   },
      // ) :
      // Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(20),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         SvgPicture.asset('assets/images/download.png'),
      //         SizedBox(height: 30.h,),
      //         CustomMaterialButton(
      //           function: () {
      //             // navigatorTo(context , LoginScreen());
      //           },
      //           text:"hhhhhhhhh",
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
