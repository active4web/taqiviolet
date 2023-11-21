import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/cubits/common_questionCubit/common_question_cubit.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class CommonQuestionsScreen extends StatefulWidget {
  @override
  State<CommonQuestionsScreen> createState() => _CommonQuestionsScreenState();
}

class _CommonQuestionsScreenState extends State<CommonQuestionsScreen> {
  @override
  void initState() {
    CommonQuestionCubit.get(context).getCommonQuestion();
    print("As");
    super.initState();
  }

  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    // StoresCubit cubit = StoresCubit.get(context);
    // cubit.getDataFromShops();
    return BlocConsumer<CommonQuestionCubit, CommonQuestionState>(
      listener: (context, state) {},
      builder: (context, state) {
        CommonQuestionCubit cubit = CommonQuestionCubit.get(context);
        return Scaffold(
          appBar: CustomAppBar(title: "commonQuestions".tr()),
          // body: cubit.storeListOfData == null
          //     ? Center(
          //         child: CircularProgressIndicator(
          //           color: Colors.black,
          //         ),
          //       )
          //     : Padding(
          //         padding: const EdgeInsets.all(20),
          //         child: GridView.builder(
          //           shrinkWrap: true,
          //           physics: AlwaysScrollableScrollPhysics(),
          //           itemCount: cubit.storeListOfData!.length,
          //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //               crossAxisCount: 2,
          //               childAspectRatio: 4 / 5,
          //               mainAxisSpacing: 10,
          //               crossAxisSpacing: 10),
          //           itemBuilder: (context, index) => Container(
          //             // height: MediaQuery.of(context).size.height * 0.45,
          //             width: MediaQuery.of(context).size.width * 0.5,
          //             child: Column(
          //               children: [
          //                 InkWell(
          //                   onTap: () {
          //                     cubit.emitAllShops();
          //                     Navigator.of(context).push(
          //                       MaterialPageRoute(
          //                           builder: (_) => StoreCategoriesScreen(
          //                                 storeId:
          //                                     (cubit.storeListOfData![index].iD)!,
          //                               )
          //                           //    ShopProfileScreen(
          //                           //     Id: cubit.storeListOfData[index].iD,
          //                           //     index: index,
          //                           //   ),
          //                           ),
          //                     );
          //                   },
          //                   child: Container(
          //                       height:
          //                           MediaQuery.of(context).size.height * 0.23,
          //                       width: MediaQuery.of(context).size.width * 0.37,
          //                       decoration: BoxDecoration(
          //                           color: Colors.grey.shade300,
          //                           borderRadius: BorderRadius.circular(10)),
          //                       child: ClipRRect(
          //                         borderRadius: BorderRadius.circular(10),
          //                         child: Image(
          //                           image: NetworkImage(
          //                             '${cubit.storeListOfData![index].image}',
          //                           ),
          //                           fit: BoxFit.cover,
          //                         ),
          //                       )),
          //                 ),
          //                 SizedBox(
          //                   height: 10,
          //                 ),
          //                 Align(
          //                   alignment: AlignmentDirectional.center,
          //                   child: Padding(
          //                     padding:
          //                         const EdgeInsets.symmetric(horizontal: 15.0),
          //                     child: Text(
          //                     '${cubit.storeListOfData![index].name}',
          //                       style: TextStyle(
          //                           fontWeight: FontWeight.bold, fontSize: 16),
          //                       overflow: TextOverflow.ellipsis,
          //                     ),
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          body: ConditionalBuilder(
            condition: state is! getCommonQuestionLoading,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child:
                cubit.commonQuestionModel!.data!.questionsList!.length == 0 ?
                    Center(
                      child: Text("لا يوجد اسئلة"),
                    ):
                ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, mainIndex) {
                    return Column(
                      children: [
                      /*  TextButton(
                          onPressed: () {
                            navigateTo(
                                context,
                                AnswerCommonQuestionsScreen(
                                  id: cubit.commonQuestionModel!.data!
                                      .questionsList![index].id!,
                                  index: index,
                                ));
                          },
                          child: Text(
                              '${cubit.commonQuestionModel!.data!.questionsList![index].name}',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18)),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: 10.0,
                            bottom: 10.0,
                            start: 10.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.blue,
                          ),
                        ),*/
                        InkWell(
                          onTap: (){
                            cubit.changeState(mainIndex);
                          },
                          child: Row(
                            children:[
                              Expanded(
                                child: Text(
                                    '${cubit.commonQuestionModel!.data!.questionsList![mainIndex].name}',
                                    style: TextStyle(color: Colors.blue, fontSize: 18),
                                  ),
                              ),
                              Spacer(),
                              cubit.selectedIndex ==mainIndex ? Icon(
                              Icons.expand_more,
                                color: Colors.blue,
                              )
                                  : Icon(
                              Icons.navigate_next,
                                color: Colors.blue,
                              ),

                            ]
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        cubit.selectedIndex == mainIndex ?
                            SizedBox(
                              height: 100,
                              child: ListView.builder(itemBuilder: (context, index) => Text(
                                '${CommonQuestionCubit.get(context).commonQuestionModel!.data!.questionsList![mainIndex].listAnswers![index].answer}',
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),
                              physics: BouncingScrollPhysics(),
                              itemCount: CommonQuestionCubit.get(context).commonQuestionModel!.data!.questionsList![mainIndex].listAnswers!.length,
                              ),
                            )
                        : SizedBox(),
                       Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: 10.0,
                            bottom: 10.0,
                            start: 10.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.blue,
                          ),
                         ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount:
                      cubit.commonQuestionModel!.data!.questionsList!.length,
                ),
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
