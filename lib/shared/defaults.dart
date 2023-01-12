import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safsofa/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:safsofa/cubits/favorites_cubit/favorites_state.dart';
import 'package:safsofa/screens/display_products_screen.dart';
import 'package:safsofa/shared/components/custom_text_form_field.dart';
import 'package:safsofa/shared/constants.dart';

import '../models/cart_models/cart_local_model/cart_local_model.dart';
import 'components/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void navigateTo(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void navigateReplacement(BuildContext context, Widget screen) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screen));
}

void navigateAndFinish(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => screen), (route) => false);
}

Uint8List decodeImage(String image) {
  Uint8List result;
  result = Base64Codec().decode(image);
  return result;
}

Future<bool> showToast({
  @required String text,
  @required Color color,
}) {
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showAlertDialogWithAction(
    {BuildContext context,
    String message,
    Color messageColor = kLightGoldColor,
    String imagePath,
    String buttonText,
    Function action}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Color(0xffF8F8F8),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              message,
              style: TextStyle(
                  fontSize: 20,
                  color: messageColor,
                  fontWeight: FontWeight.w500),
              // textDirection: TextDirection.rtl,
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            CustomButton(
              onTap: action,
              text: buttonText,
            )
          ],
        ),
      ),
    ),
  );
}

Future<dynamic> showCustomBottomSheet({BuildContext context, Widget content}) {
  return showModalBottomSheet(
      context: context,
      builder: (context) => ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              //height: MediaQuery.of(context).size.height*0.5,
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              //height: 350,
              child: content,
            ),
          ));
}

CartLocalModel cartProducts;

// void ensureDeleteMessage({context, onTap, String text}) {
//   showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//             backgroundColor: Color(0xffF8F8F8),
//             title: Center(
//                 child: Text(
//               text,
//               textDirection: TextDirection.rtl,
//               style: TextStyle(
//                 color: kPrimaryColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             )),
//             actionsAlignment: MainAxisAlignment.spaceEvenly,
//             actions: [
//               TextButton(
//                 child: Text(
//                   'تراجع',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(kPrimaryColor),
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               TextButton(
//                 child: Text(
//                   'حذف',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.red),
//                 ),
//                 onPressed: onTap,
//               ),
//             ],
//           ));
// }

// void showLoadingDialogue(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       content: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SpinKitFadingCircle(
//               color: kPrimaryColor,
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

/// Print Long String
void printLongString(String text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(text)
      .forEach((RegExpMatch match) => print(match.group(0)));
}

void showFavoriteChoiceDialogue(
    {@required BuildContext context, @required int productId}) {
  TextEditingController listName = TextEditingController();
  showModalBottomSheet(
      context: context,
      builder: (context) {
        FavoritesCubit.get(context).getFavListData();
        return BlocConsumer<FavoritesCubit, FavoritesState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 60,
                  vertical: MediaQuery.of(context).size.height / 70),
              child: state is FavoritesListSuccess
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "addToOneOfYourFavoriteLists".tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kDarkGoldColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 35,
                        ),
                        SizedBox(
                          height: 80,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              if (FavoritesCubit.get(context)
                                  .favListModel
                                  .data
                                  .isNotEmpty)
                                SizedBox(
                                  height: 80,
                                  child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: FavoritesCubit.get(context)
                                        .favListModel
                                        .data
                                        .length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          FavoritesCubit.get(context)
                                              .addFavProductToFavList(
                                                  listId: FavoritesCubit.get(
                                                          context)
                                                      .favListModel
                                                      .data[index]
                                                      .id,
                                                  productId: productId);
                                        },
                                        child: Wrap(
                                          direction: Axis.vertical,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Icon(
                                                CupertinoIcons
                                                    .heart_circle_fill,
                                                color: Colors.red,
                                              ),
                                            ),
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: 70,
                                              ),
                                              child: Text(
                                                FavoritesCubit.get(context)
                                                    .favListModel
                                                    .data[index]
                                                    .name,
                                                style: TextStyle(
                                                  color: kDarkGoldColor,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          60,
                                    ),
                                  ),
                                ),
                              if (FavoritesCubit.get(context)
                                  .favListModel
                                  .data
                                  .isNotEmpty)
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 60,
                                ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: BlocConsumer<FavoritesCubit,
                                            FavoritesState>(
                                          listener: (context, state) {},
                                          builder: (context, state) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CustomTextFormField(
                                                  hintText:
                                                      "theNameOfYourFavoriteList"
                                                          .tr(),
                                                  controller: listName,
                                                  fillColor: Colors.grey,
                                                  hintColor: Colors.black87,
                                                  textColor: kDarkGoldColor,
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      50,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        FavoritesCubit.get(
                                                                context)
                                                            .createNewFavList(
                                                                listName:
                                                                    listName
                                                                        .text,
                                                                context:
                                                                    context,
                                                                productId:
                                                                    productId);
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 70,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.green,
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(14),
                                                        ),
                                                        child: Text(
                                                          "create".tr(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () =>
                                                          Navigator.of(context)
                                                              .pop(),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 70,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.grey,
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(14),
                                                        ),
                                                        child: Text(
                                                          "cancel".tr(),
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Wrap(
                                  direction: Axis.vertical,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Icon(
                                        CupertinoIcons.add_circled,
                                        color: Colors.black,
                                      ),
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: 70,
                                      ),
                                      child: Text(
                                        'انشأ قائمه',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   width: 60,
                        //   height: 60,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.rectangle,
                        //     borderRadius: BorderRadius.circular(16),
                        //     color: Colors.grey.shade200,
                        //   ),
                        //   child: Icon(
                        //     CupertinoIcons.add_circled,
                        //     color: Colors.black,
                        //   ),
                        // ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
            );
          },
        );
      });
}
