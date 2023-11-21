// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:safsofa/shared/constants.dart';
//
// import '../cubits/dataInList/data_in_list_cubit.dart';
// import '../cubits/listsCubit/lists_cubit.dart';
// import '../shared/defaults.dart';
// import 'item_in_list.dart';
//
// class MyLists extends StatefulWidget {
//   @override
//   _MyListsState createState() => _MyListsState();
// }
//
// class _MyListsState extends State<MyLists> {
//   TextEditingController _textEditingController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     ListsCubit cubit = ListsCubit.get(context);
//     return SafeArea(
//         child: AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle.dark,
//       child: DefaultTabController(
//           // Added
//           length: 2, // Added
//           initialIndex: 0, //Added
//           child: Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               leading: IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: Colors.black,
//                   )),
//               backgroundColor: Colors.white,
//               elevation: 0.0,
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: BlocConsumer<ListsCubit, ListsState>(
//                 listener: (context, state) {
//                   // TODO: implement listener
//                 },
//                 builder: (context, state) {
//                   state is ListsInitial ? cubit.getListsData() : log("getdata");
//                   // if (state is ListsLoadingState) {
//                   //   return Center(
//                   //     child: Text("the data is Uploading......"),
//                   //   );
//                   // }
//                   return cubit.listsModel == null
//                       ? Center(
//                           child: CircularProgressIndicator(),
//                         )
//                       : Column(
//                           children: [
//                             Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text("القائمة و السجل"),
//                                   TextButton(
//                                       onPressed: () {
//                                         showModalBottomSheet<void>(
//                                           context: context,
//                                           builder: (BuildContext context) {
//                                             return Container(
//                                               //  height: 200,
//                                               //color: Colors.amber,
//                                               child: Center(
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(8.0),
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     mainAxisSize:
//                                                         MainAxisSize.min,
//                                                     children: <Widget>[
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: const Text(
//                                                             'انشاء قائمة جديدة'),
//                                                       ),
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: TextField(
//                                                           controller:
//                                                               _textEditingController,
//                                                           decoration:
//                                                               const InputDecoration(
//                                                             border:
//                                                                 OutlineInputBorder(
//                                                                     //Outline border type for TextFeild
//                                                                     borderRadius:
//                                                                         BorderRadius.all(Radius.circular(
//                                                                             20)),
//                                                                     borderSide:
//                                                                         BorderSide(
//                                                                       color: Colors
//                                                                           .redAccent,
//                                                                       width: 3,
//                                                                     )),
//                                                             labelText:
//                                                                 'قائمة التسوق',
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text(
//                                                             "استخدم القوائم لحفظ المنتجات لاحقا جميع القوائم خاصة الا اذا قمت بمشاركتها مع الاخرين"),
//                                                       ),
//                                                       ElevatedButton(
//                                                         child: const Text(
//                                                             'انشي قائمة'),
//                                                         onPressed: () {
//                                                           cubit.postlistsData(
//                                                               listName:
//                                                                   _textEditingController
//                                                                       .text);
//
//                                                           _textEditingController.clear();
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                       ),
//                                                       ElevatedButton(
//                                                         child:
//                                                             const Text('غلق'),
//                                                         onPressed: () =>
//                                                             Navigator.pop(
//                                                                 context),
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       },
//                                       child: Text("+ انشاء قائمة"))
//                                 ]),
//                             Container(
//                               height: 80,
//                               child: TabBar(onTap: (index) {}, tabs: [
//                                 Tab(
//                                   icon: Icon(
//                                     Icons.email_outlined,
//                                     color: Colors.black,
//                                   ),
//                                   child: Text("قوائم اصدقائك",
//                                       style: TextStyle(color: Colors.black)),
//                                   // text: "all",
//                                 ),
//                                 Tab(
//                                   icon: Icon(
//                                     Icons.mark_email_unread,
//                                     color: Colors.black,
//                                   ),
//                                   child: Text("قوائمك",
//                                       style: TextStyle(color: Colors.black)),
//                                   // text: "all",
//                                 ),
//                               ]),
//                             ),
//                             Expanded(
//                               child: TabBarView(children: [
//                                 ListView.builder(
//                                     physics: BouncingScrollPhysics(),
//                                     itemCount: cubit
//                                         .listsModel!.data!.shareList!.length,
//                                     itemBuilder: (context, pos) {
//                                       return InkWell(
//                                         onTap: () {
//                                           log('${cubit.productDetailsModel}');
//                                           log("add   " * 10);
//
//                                           DataInListCubit.get(context)
//                                               .postlistsData(
//                                                   id: cubit.listsModel?.data
//                                                       ?.shareList![pos].id
//                                                       .toString());
//
//                                           if (cubit.productDetailsModel !=
//                                               null) {
//                                             ///ToDo add to list
//                                             ///
//                                             cubit.addItemToList(
//                                                 id: cubit.listsModel?.data
//                                                     ?.shareList![pos].id
//                                                     .toString());
//                                           }
//
//                                           navigateTo(context, ItemInList());
//                                         },
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Card(
//                                             elevation: 8,
//                                             child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.end,
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     child: Text(cubit
//                                                         .listsModel!
//                                                         .data!
//                                                         .shareList![pos]
//                                                         .clientId
//                                                         .toString()),
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     child: Text(
//                                                         "${cubit.listsModel?.data?.shareList![pos].createdAt}"),
//                                                   ),
//                                                   IconButton(icon: Icon(Icons.delete),onPressed: (){
//                                                     cubit.deleteRosterlistsData(
//                                                         id: cubit
//                                                             .listsModel
//                                                             ?.data
//                                                             ?.shareList![
//                                                         pos]
//                                                             .id);
//                                                   },),
//                                                 ]),
//                                           ),
//                                         ),
//                                       );
//                                     }),
//                                 ListView.builder(
//                                   physics: BouncingScrollPhysics(),
//                                     itemCount: cubit
//                                         .listsModel!.data!.mainList!.length,
//                                     itemBuilder: (context, index) {
//                                       return InkWell(
//                                         onTap: () {
//                                           log("lisssss id     ${cubit.listsModel?.data?.mainList![index].id}");
//                                           DataInListCubit.get(context)
//                                                   .roster_id =
//                                               cubit.listsModel?.data
//                                                   ?.mainList![index].id;
//                                           DataInListCubit.get(context)
//                                               .postlistsData(
//                                                   id: cubit.listsModel?.data
//                                                       ?.mainList![index].id
//                                                       .toString());
//
//                                           if (cubit.productDetailsModel !=
//                                               null) {
//                                             ///ToDo add to list
//                                             ///
//                                             cubit.addItemToList(
//                                                 id: cubit.listsModel?.data
//                                                     ?.mainList![index].id
//                                                     .toString());
//                                           }
//
//                                           navigateTo(context, ItemInList());
//                                         },
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Card(
//                                             elevation: 8,
//                                             child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.end,
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     child: Text(
//                                                         "${cubit.listsModel?.data?.mainList![index].name}"),
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     child: Text(
//                                                         "${cubit.listsModel?.data?.mainList![index].createdAt}"),
//                                                   ),
//                                                   IconButton(icon: Icon(Icons.delete),onPressed: (){
//                                                     cubit
//                                                         .deleteRosterlistsData(
//                                                         id: cubit
//                                                             .listsModel
//                                                             ?.data
//                                                             ?.mainList![
//                                                         index]
//                                                             .id);
//                                                   }),
//                                                 ]),
//                                           ),
//                                         ),
//                                       );
//                                     })
//                               ]),
//                             )
//                           ],
//                         );
//                 },
//               ),
//             ),
//           )),
//     ));
//
//     Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: BlocConsumer<ListsCubit, ListsState>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             if (state is ListsLoadingState) {
//               return Center(
//                 child: Text("the data is Uploading......"),
//               );
//             }
//             return Column(
//               children: [
//                 Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("القائمة و السجل"),
//                       TextButton(
//                           onPressed: () {
//                             showModalBottomSheet<void>(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return Container(
//                                   height: 200,
//                                   color: Colors.amber,
//                                   child: Center(
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: <Widget>[
//                                         const Text('انشاء قائمة جديدة'),
//                                         TextField(
//                                           decoration: const InputDecoration(
//                                             border: OutlineInputBorder(
//                                                 //Outline border type for TextFeild
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(20)),
//                                                 borderSide: BorderSide(
//                                                   color: Colors.redAccent,
//                                                   width: 3,
//                                                 )),
//                                             labelText: 'قائمة التسوق',
//                                           ),
//                                         ),
//                                         Text(
//                                             "استخدم القوائم لحفظ المنتجات لاحقا جميع القوائم خاصة الا اذا قمت بمشاركتها مع الاخرين"),
//                                         ElevatedButton(
//                                           child: const Text('انشي قائمة'),
//                                           onPressed: () {},
//                                         ),
//                                         ElevatedButton(
//                                           child: const Text('غلق'),
//                                           onPressed: () =>
//                                               Navigator.pop(context),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           child: Text("+ انشاء قائمة"))
//                     ]),
//                 Container(
//                   height: 80,
//                   child: TabBar(onTap: (index) {}, tabs: [
//                     Tab(
//                       icon: Icon(
//                         Icons.mark_email_unread,
//                         color: Colors.black,
//                       ),
//                       child:
//                           Text("قوائمك", style: TextStyle(color: Colors.black)),
//                       // text: "all",
//                     ),
//                     Tab(
//                       icon: Icon(
//                         Icons.email_outlined,
//                         color: Colors.black,
//                       ),
//                       child: Text("قوائم اصدقائك",
//                           style: TextStyle(color: Colors.black)),
//                       // text: "all",
//                     ),
//                   ]),
//                 ),
//                 Expanded(
//                   child: TabBarView(children: [Container(), Container()]),
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
