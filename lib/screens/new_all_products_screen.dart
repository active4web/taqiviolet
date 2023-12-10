import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cubits/gify_cubit/gift_cubit.dart';
import '../cubits/subCategory/sub_cat_cubit.dart';
import '../shared/components/custom_app_bar.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../shared/components/custom_text_form_field.dart';
import '../shared/components/store_components/product_cards.dart';
import '../shared/constants.dart';
import '../shared/defaults.dart';

class NewAllProductsScreen extends StatefulWidget {
  const NewAllProductsScreen({Key? key}) : super(key: key);

  @override
  State<NewAllProductsScreen> createState() => _NewAllProductsScreenState();
}

class _NewAllProductsScreenState extends State<NewAllProductsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    GiftCubit.get(context).getAllNewProductsData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GiftCubit,GiftState>(
        listener: (context,state){},
    builder:  (context,state) {
      var cubit = GiftCubit.get(context);
      return  Scaffold(
        appBar: CustomAppBar(
          title: 'coupons'.tr(),
        ),
        body: ConditionalBuilder(
          condition: state is ! GetAllNewProductsLoadingStateOld,
          fallback: (context) => Center(child: RefreshProgressIndicator()),
          builder: (context){
            return GridView.builder(
              shrinkWrap: true,
              physics:
              NeverScrollableScrollPhysics(),
              itemCount: cubit.getAllNewProductsNewModel!.data!.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 15 / 30,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10),
              itemBuilder: (context, index) =>
                  VerticalProductCard(
                    cubit: cubit,
                    isFavourite: cubit.getAllNewProductsNewModel!.data![index].hasFavorites == 1,
                    image: cubit.getAllNewProductsNewModel!.data![index].image,
                    currentPrice: cubit.getAllNewProductsNewModel!.data![index].currentPrice,
                    oldPrice: cubit.getAllNewProductsNewModel!.data![index].oldPrice,
                    productName: cubit.getAllNewProductsNewModel!.data![index].name,
                    productId: cubit.getAllNewProductsNewModel!.data![index].id,
                    totalRate: cubit.getAllNewProductsNewModel!.data![index].hasReviews,
                    onFavPressed: () {
                      if (kToken != null && kToken!.isNotEmpty) {
                        if (cubit.getAllNewProductsNewModel!.data![
                        index].hasFavorites == 1) {
                          SubCatCubit.get(context).removeFavorite(
                              prodId: cubit.getAllNewProductsNewModel!.data![index].id!);
                        } else {
                          ///////////////////////////////////////////////////

                          TextEditingController
                          listName =
                          TextEditingController();
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                SubCatCubit.get(context).getFavListData();
                                return BlocConsumer<
                                    SubCatCubit,
                                    SubCatState>(
                                  listener: (context,
                                      state) {},
                                  builder: (context,
                                      state) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                          MediaQuery.of(context).size.width /
                                              60,
                                          vertical: MediaQuery.of(context)
                                              .size
                                              .height /
                                              70),
                                      child: state
                                      is ProductSuccess
                                          ? Column(
                                        mainAxisSize:
                                        MainAxisSize.min,
                                        children: [
                                          Align(
                                            alignment:
                                            AlignmentDirectional.center,
                                            child:
                                            Text(
                                              "addToOneOfYourFavoriteLists".tr(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: kDarkGoldColor, fontSize: 22, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                            MediaQuery.of(context).size.height / 35,
                                          ),
                                          SizedBox(
                                            height:
                                            80,
                                            child:
                                            ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: [
                                                if (SubCatCubit.get(context).favListModel!.data!.isNotEmpty)
                                                  SizedBox(
                                                    height: 80,
                                                    child: ListView.separated(
                                                      physics: NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: SubCatCubit.get(context).favListModel!.data!.length,
                                                      itemBuilder: (context, index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            SubCatCubit.get(context).addFavProductToFavList(
                                                              index: index,
                                                                listId: SubCatCubit.get(context).favListModel!.data![index].iD!,
                                                                productId: cubit.getAllNewProductsNewModel!.data![index].id!, context: context);
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
                                                                  CupertinoIcons.heart_circle_fill,
                                                                  color: Colors.red,
                                                                ),
                                                              ),
                                                              ConstrainedBox(
                                                                constraints: BoxConstraints(
                                                                  maxWidth: 70,
                                                                ),
                                                                child: Text(
                                                                  "${SubCatCubit.get(context).favListModel?.data![index].name}",
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
                                                      separatorBuilder: (context, index) => SizedBox(
                                                        width: MediaQuery.of(context).size.width / 60,
                                                      ),
                                                    ),
                                                  ),
                                                if (SubCatCubit.get(context).favListModel!.data!.isNotEmpty)
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width / 60,
                                                  ),
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: BlocConsumer<SubCatCubit, SubCatState>(
                                                            listener: (context, state) {},
                                                            builder: (context, state) {
                                                              return Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  CustomTextFormField(
                                                                    hintText: "theNameOfYourFavoriteList".tr(),
                                                                    controller: listName,
                                                                    fillColor: Colors.grey,
                                                                    hintColor: Colors.black87,
                                                                    textColor: kDarkGoldColor,
                                                                    validate: (value) {},
                                                                  ),
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context).size.height / 50,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                    children: [
                                                                      InkWell(
                                                                        onTap: () {
                                                                          Navigator.pop(context);
                                                                          SubCatCubit.get(context).createNewFavList(
                                                                            listName: listName.text
                                                                            , context: context,
                                                                            productId: SubCatCubit.get(context).productFromCatList![index].id,
                                                                            index: index,
                                                                          );
                                                                        },
                                                                        child: Container(
                                                                          alignment: Alignment.center,
                                                                          width: 70,
                                                                          height: 40,
                                                                          decoration: BoxDecoration(
                                                                            color: Colors.green,
                                                                            shape: BoxShape.rectangle,
                                                                            borderRadius: BorderRadius.circular(14),
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
                                                                        onTap: () => Navigator.of(context).pop(),
                                                                        child: Container(
                                                                          alignment: Alignment.center,
                                                                          width: 70,
                                                                          height: 40,
                                                                          decoration: BoxDecoration(
                                                                            color: Colors.grey,
                                                                            shape: BoxShape.rectangle,
                                                                            borderRadius: BorderRadius.circular(14),
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
                                                          "createList".tr(),
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
                                        mainAxisSize:
                                        MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child:
                                            CircularProgressIndicator(),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              });
                        }
                        //////////////////////////////////////////////////////////

                        // isFavourite = !isFavourite;
                        // log(cubit
                        //         .productFromCatList[
                        //             index]
                        //         .id
                        //         .toString() +
                        //     "DDDDD");
                        // cubit.updateFavorite(
                        //     prodId: cubit
                        //         .productFromCatList[
                        //             index]
                        //         .id);

                        // cubit.emit(ChangeIconColor());
                      } else {
                        showToast(
                            text: 'pleaseLoginFirst'
                                .tr(),
                            color: Colors.black);
                      }
                    },
                  ),
            );
          },
        ),
      );
    }

    );
  }
}
