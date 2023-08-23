import 'dart:ui';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/appCubit/app_cubit.dart';
import 'package:safsofa/cubits/listsCubit/lists_cubit.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/screens/home_layout.dart';
import 'package:safsofa/screens/mylist_details.dart';
import 'package:safsofa/screens/register_screens/login_screen.dart';
import 'package:safsofa/screens/register_screens/register_choice_screen.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/components/custom_network_image.dart';
import 'package:safsofa/shared/components/dialogs.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class MyListScreen extends StatefulWidget {
  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    ListsCubit.get(context).getListsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(CacheHelper.getData("token"));
    ListsCubit cubit = ListsCubit.get(context);
    return WillPopScope(
      onWillPop: () async {
        displayLogoutDialog(context, "closeApplication".tr(), "wantExit".tr());
        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'myList'.tr(),
        ),
        body: BlocConsumer<ListsCubit, ListsState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            ListsCubit cubit = ListsCubit.get(context);
            return
              kToken != null &&
                  kToken!.isNotEmpty ?
              ConditionalBuilder(
              condition: state is! ListsLoadingState,
              builder: (context) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(children: [
                          Text("myList".tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Spacer(),
                          TextButton(
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 20, left: 20, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
                                          child: Column(
                                            children: <Widget>[
                                              Padding(padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    const Text('انشاء قائمة جديدة'),
                                                    Spacer(),
                                                    IconButton(
                                                        onPressed: () {
                                                          cubit.postlistsData(
                                                              listName: _textEditingController.text);
                                                          _textEditingController.clear();
                                                          Navigator.pop(context);
                                                        },
                                                        icon:
                                                            Icon(Icons.close)),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextField(
                                                  controller:
                                                      _textEditingController,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: OutlineInputBorder(
                                                        //Outline border type for TextFeild
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.redAccent,
                                                          width: 3,
                                                        )),
                                                    labelText: 'قائمة التسوق',
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    "استخدم القوائم لحفظ المنتجات لاحقا جميع القوائم خاصة الا اذا قمت بمشاركتها مع الاخرين"),
                                              ),
                                              ElevatedButton(
                                                child: const Text('انشي قائمة'),
                                                onPressed: () {
                                                  cubit.postlistsData(
                                                      listName:
                                                          _textEditingController
                                                              .text);

                                                  _textEditingController
                                                      .clear();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              SizedBox(
                                                height: 40,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  Text("createList".tr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  Text(" +",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ],
                              )),
                        ]),
                        CacheHelper.getData('closed') != true
                            ? Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade300)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.bookmark_add_outlined,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            "introList".tr(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: Colors.blue,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                ),
                                                child: Text(
                                                  'new'.tr(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              )),
                                          Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              CacheHelper.setData(
                                                  key: 'closed', value: true);
                                              CacheHelper.getData('closed');
                                              print(CacheHelper.getData(
                                                  'closed'));
                                              setState(() {});
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        'introductionList'.tr(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        cubit.listsModel!.data!.list!.isNotEmpty?
                        ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        cubit.postDetailsListsData(id: cubit.listsModel?.data?.list?[index].listId);
                                    navigateTo(context, MyListDetailsScreen(
                                          nameList: "${cubit.listsModel?.data?.list?[index].listName}",
                                        ));
                                      },
                                      child: Text(
                                          cubit.listsModel!.data!.list![index].listName.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start),
                                    ),
                                    Spacer(),
                                    IconButton(onPressed: (){
                                      cubit.deleteRosterlistsData(
                                       id: cubit.listsModel!.data!.list![index].listId
                                      );
                                    }, icon: Icon(Icons.delete))
                                  ],
                                ),
                                SizedBox(
                            height: 5
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${cubit.listsModel!.data!.list![index].totalProducts}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'product'.tr(),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),

                                /*        SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '|',`
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'updateIn'.tr(),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      cubit
                                          .listsModel!
                                          .data!.list![0].toString(),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),*/
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                if(cubit.listsModel!.data!.list![index].totalProducts!=0 )
                                InkWell(
                                  child: Row(
                                    children: [
                                      cubit.listsModel!.data!.list![index].listImg1 != null
                                          ? Expanded(
                                        child: CustomNetworkImage(
                                          image: cubit.listsModel!.data!.list![index].listImg1.toString(),
                                          border: BorderRadius.circular(10),
                                          height: 200,
                                        ),
                                      )
                                          : Expanded(
                                        child: Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                cubit.listsModel!.data!.list![index].listImg2 != null
                                                    ? Expanded(
                                                  child: CustomNetworkImage(
                                                    image:
                                                    cubit.listsModel!.data!.list![index].listImg2.toString(),
                                                    border:
                                                    BorderRadius.circular(
                                                        10),
                                                    height: 100,
                                                  ),
                                                )
                                                    : Expanded(
                                                  child: Container(
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                cubit.listsModel!.data!.list![index].listImg3 !=null
                                                    ? Expanded(
                                                  child: CustomNetworkImage(
                                                    image:
                                                    cubit.listsModel!.data!.list![index].listImg3.toString(),
                                                    border:
                                                    BorderRadius.circular(
                                                        10),
                                                    height: 100,
                                                  ),
                                                )
                                                    : Expanded(
                                                  child: Container(
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Row(
                                              children: [
                                                cubit.listsModel!.data!.list![index].listImg4 != null
                                                    ? Expanded(
                                                  child: CustomNetworkImage(
                                                    image:
                                                    cubit.listsModel!.data!.list![index].listImg4.toString(),
                                                    border:
                                                    BorderRadius.circular(
                                                        10),
                                                    height: 100,
                                                  ),
                                                )
                                                    : Expanded(
                                                  child: Container(
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                cubit.listsModel!.data!.list![index].listImg5 != null
                                                    ? Expanded(
                                                  child: CustomNetworkImage(
                                                    image:
                                                    cubit.listsModel!.data!.list![index].listImg5.toString(),
                                                    border:
                                                    BorderRadius.circular(
                                                        10),
                                                    height: 100,
                                                  ),
                                                )
                                                    : Expanded(
                                                  child: Container(
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: (){
                                    cubit.postDetailsListsData(id: cubit.listsModel?.data?.list?[index].listId);
                                    navigateTo(context, MyListDetailsScreen(
                                      nameList: "${cubit.listsModel?.data?.list?[index].listName}",
                                    ));
                                  },
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          itemCount: cubit.listsModel!.data!.list!.length,
                        ):
                            Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.bookmark_add_outlined,
                                    color: Colors.grey,
                                    size: MediaQuery.of(context).size.width / 5,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height / 40,
                                  ),
                                  Text(
                                    "youDontHaveLists".tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: MediaQuery.of(context).size.width / 22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ],
                    ),
                  ),
                );
              },
              fallback: (context) => Center(child: RefreshProgressIndicator()),
            ):
              Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bookmark_add_outlined,
                        color: Colors.grey,
                        size: MediaQuery.of(context).size.width / 5,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      Text(
                        "logInToViewYourFavoriteProducts".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: MediaQuery.of(context).size.width / 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 30),
                        child: InkWell(
                          onTap: () {
                            AppCubit.get(context).selectedIndex=3;
                            navigateAndFinish(context, HomeLayout());
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 14,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              color: kDarkGoldColor,
                              gradient: LinearGradient(
                                colors: [
                                  kLightGoldColor,
                                  kDarkGoldColor,
                                ],
                              ),
                            ),
                            child: Text(
                              "Login".tr(),
                              style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.width / 16,
                                color: Colors.white,
                                letterSpacing: 1.8,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      Text.rich(
                        TextSpan(
                            text: "DoNotHaveAnAccount?".tr(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                MediaQuery.of(context).size.width / 22),
                            children: [
                              TextSpan(
                                  text: "SignUp".tr(),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      return navigateTo(
                                          context, RegisterChoiceScreen());
                                    },
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 192, 135, 13)))
                            ]),
                        textAlign: TextAlign.center,
                      ),
                    ]
                )
              );




          },
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    ListsCubit.get(context).listsModel?.data?.list?.clear();
    super.didChangeDependencies();
  }
}
