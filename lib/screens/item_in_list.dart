import 'dart:developer';

import 'package:flutter/material.dart';

import '../cubits/dataInList/data_in_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemInList extends StatefulWidget {

  @override
  _ItemInListState createState() => _ItemInListState();
}

class _ItemInListState extends State<ItemInList> {
  @override
  Widget build(BuildContext context) {
    DataInListCubit cubit = DataInListCubit.get(context);
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<DataInListCubit, DataInListState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is DataInListSuccessState) {
              log("iteeeeeemmmm innnn   lisssstttt");
              log('$state');
              log('${cubit.dataInList!.data!.products!.length}');
            }
            return state is! DataInListSuccessState
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("قائمة التسوق",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                Text("قوائمك",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ]),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: cubit.dataInList!.data!.products!.length,
                              itemBuilder: (context, pos) {
                                return Card(
                                  child: Column(children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                cubit.postdeletItemlistsData(
                                                    id: cubit.dataInList?.data
                                                        ?.products![pos].id
                                                        .toString());
                                              },
                                              icon: Icon(Icons.clear)),
                                          SizedBox()
                                        ]),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${cubit.dataInList?.data?.products![pos].name}"),
                                          Text("Name"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${cubit.dataInList?.data?.products![pos].price.toString()}"),
                                          Text("price"),
                                        ],
                                      ),
                                    ),
                                  ]),
                                );
                              }),
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
