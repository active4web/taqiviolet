//
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
//
// class AppDrawer extends StatelessWidget {
//    AppDrawer({Key? key}) : super(key: key);
//   final GlobalKey<FormState> _formKeyAlertDialog = GlobalKey<FormState>();
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _massageController = TextEditingController();
//   Widget buildDrawerHeader(context) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsetsDirectional.fromSTEB(70, 10, 70, 10),
//           decoration: BoxDecoration(
//             shape: BoxShape.rectangle,
//             color: AppColors.foreignColor,
//           ),
//           child: SizedBox(
//               height: 70.h, child: SvgPicture.asset(AppImages.logoImage)),
//         ),
//         SizedBox(
//           height: 5.h,
//         ),
//         AppConstance.token != null ?
//         AppConstance.name!.isNotEmpty
//             ? Text(
//                 AppConstance.name.toString(),
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyText2
//                     ?.copyWith(color: AppColors.whiteColor),
//                 textAlign: TextAlign.start,
//               )
//             : const SizedBox():const SizedBox(),
//
//         SizedBox(
//           height: 3.h,
//         ),
//         AppConstance.token != null ?
//
//         AppConstance.email!.isNotEmpty
//             ? Text(
//                 AppConstance.email.toString(),
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyText2
//                     ?.copyWith(color: AppColors.whiteColor),
//               )
//             : const SizedBox():const SizedBox(),
//         SizedBox(
//           height: 3.h,
//         ),
//         AppConstance.token != null ?
//
//         AppConstance.phone!.isNotEmpty
//             ? Text(
//                 AppConstance.phone.toString(),
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyText2
//                     ?.copyWith(color: AppColors.whiteColor),
//               )
//             : const SizedBox():const SizedBox(),
//         SizedBox(
//           height: 3.h,
//         ),
//         AppConstance.token != null ?
//         AppConstance.address!.isNotEmpty
//             ? Text(
//                 AppConstance.address.toString(),
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyText2
//                     ?.copyWith(color: AppColors.whiteColor),
//               )
//             : const SizedBox():const SizedBox(),
//
//       ],
//     );
//   }
//
//   Widget buildDrawerListItems({
//     required String title,
//     Function()? onTap,
//     Widget? trailing,
//     required BuildContext context,
//   }) {
//     return ListTile(
//       title: Text(
//         title,
//         style: Theme.of(context).textTheme.subtitle2,
//       ),
//       trailing: trailing,
//       onTap: onTap,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthCubit,AuthState>(
//       listener:(context,state){
//         if(state is LogoutSuccessState){
//           navigatorAndRemove(context, LoginScreen());
//           showToast(text: state.success,state:ToastStates.success);
//         }
//         if(state is DeleteMyAccountSuccessState){
//           navigatorAndRemove(context, LoginScreen());
//           showToast(text: state.success,state:ToastStates.success);
//         }
//       } ,
//       builder:(context,state){
//         AuthCubit  cubit = AuthCubit.get(context);
//         return Drawer(
//           child: ListView(
//             physics: const BouncingScrollPhysics(),
//             padding: EdgeInsets.zero,
//             children: [
//               SizedBox(
//                 height:        AppConstance.token != null ?
//                 280.h:200.h,
//                 child: DrawerHeader(
//                   decoration: BoxDecoration(
//                     color: AppColors.foreignColor,
//                   ),
//                   child: buildDrawerHeader(context),
//                 ),
//               ),
//               buildDrawerListItems(
//                   title: AppStrings.main(context).toString(),
//                   trailing: const Icon(Icons.home),
//                   context: context,
//                   onTap: () {
//                     navigatorTo(context,  MainScreen());
//                   }),
//               const CustomMyDivider(),
//               buildDrawerListItems(
//                   title: AppStrings.changeLanguage(context).toString(),
//                   trailing: const Icon(Icons.language),
//                   context: context,
//                   onTap: () {
//                     customAlertDialog(
//                       context: context,
//                       dismissOnBackKeyPress: false,
//                       dialogType: DialogType.question,
//                       functionOnBackKeyPress: (){},
//                       btnOk:true,
//                         textButton: AppStrings.done(context).toString(),
//                       body:  CustomDropDown(
//                         listItems:  AppCubit.get(context).dropDownButton,
//                         initialValue: AppCubit.get(context).lang,
//                         suffixIcon: false,
//                         onChange: (value){
//                           AppConstance.lang = value;
//                           AppCubit.get(context)
//                               .changeLanguage(languageCode: value!);
//                         },
//                         validator: (value){},
//
//                       ),
//                     );
//                   }),
//               const CustomMyDivider(),
//               buildDrawerListItems(
//                   title: AppStrings.technicalSupport(context).toString(),
//                   trailing: const Icon(Icons.support_agent_outlined),
//                   context: context,
//                   onTap: () {
//                     customTechnicalSupportComponent(
//                       context: context,
//                       formKeyAlertDialog: _formKeyAlertDialog,
//                       massageController: _massageController,
//                       phoneNumberController: _phoneNumberController,
//                       function: (){
//                         if (_formKeyAlertDialog.currentState!.validate()) {
//                           cubit.contactSupport(
//                             phone: _phoneNumberController
//                                 .text
//                                 .trim(),
//                             massage: _massageController
//                                 .text
//                                 .trim(),
//                           );
//                         }
//                       }
//                     );
//                   }),
//
//               AppConstance.token != null ?
//               const CustomMyDivider():const SizedBox(),
//               buildDrawerListItems(
//                   title: AppStrings.myAccount(context).toString(),
//                   trailing: const Icon(Icons.person),
//                   context: context,
//                   onTap: () {
//                    navigatorTo(context, MyAccountScreen());
//                   }),
//               AppConstance.token != null ?
//               const CustomMyDivider():const SizedBox(),
//               AppConstance.token != null ?buildDrawerListItems(
//                   title: AppStrings.policy(context).toString(),
//                   trailing: Icon(Icons.policy_outlined),
//                   context: context):const SizedBox(),
//               AppConstance.token != null ?const CustomMyDivider():const SizedBox(),
//
//               AppConstance.token != null ?
//               buildDrawerListItems(
//                 title: AppStrings.deleteMyAccount(context).toString(),
//                 trailing: const Icon(Icons.group_remove_outlined),
//                 context: context,
//                 onTap: () {
//                   customAlertDialog(
//                     context: context,
//                     dismissOnBackKeyPress: true,
//                     dialogType: DialogType.question,
//                     functionOnBackKeyPress: (){},
//                     function: (){
//                       cubit.deleteMyAccount();
//                     },
//                     textButton: AppStrings.done(context).toString(),
//                     body: Text(AppStrings.deleteYourAccount(context).toString(),
//                     style: Theme.of(context).textTheme.bodyText2,
//                     )
//                   );
//                 },
//               ):const SizedBox(),
//               const CustomMyDivider(),
//               buildDrawerListItems(
//                   title: AppConstance.token != null ?AppStrings.logout(context).toString():AppStrings.login(context).toString(),
//                   trailing:AppConstance.token != null  ? const Icon(Icons.logout):const Icon(Icons.login),
//                   context: context,
//                   onTap:AppConstance.token != null  ? () {
//                     customAlertDialog(
//                         context: context,
//                         dismissOnBackKeyPress: true,
//                         dialogType: DialogType.question,
//                         btnCancel: true,
//                         functionOnBackKeyPress: (){},
//                         function: (){
//                           cubit.logout();
//                         },
//                         textButton: AppStrings.done(context).toString(),
//                         body: Text(AppStrings.logoutYourAccount(context).toString(),
//                           style: Theme.of(context).textTheme.bodyText2,
//                         )
//                     );
//                   }: (){
//                     customAlertDialog(
//                         context: context,
//                         dismissOnBackKeyPress: true,
//                         dialogType: DialogType.question,
//                         btnCancel: true,
//                         functionOnBackKeyPress: (){},
//                         function: (){
//                           navigatorAndRemove(context,  LoginScreen());
//                         },
//                         textButton: AppStrings.done(context).toString(),
//                         body: Text(AppStrings.loginYourAccount(context).toString(),
//                           style: Theme.of(context).textTheme.bodyText2,
//                         )
//                     );
//                   }),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
