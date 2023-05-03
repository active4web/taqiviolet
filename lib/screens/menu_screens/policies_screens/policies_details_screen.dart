// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:safsofa/cubits/blogCubit/policies_cubit.dart';
//
// class BlogDetailsScreen extends StatelessWidget {
//   String indexSt;
//   BlogDetailsScreen({@required this.indexSt});
//
//   int index = 0;
//   List data = [];
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<BlogCubit, PoliciesState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var cubit = BlogCubit.get(context);
//         if (indexSt.contains("a")) {
//           index = int.parse(indexSt.substring(0, 1));
//           data = cubit.lastblog;
//         } else {
//           index = int.parse(indexSt);
//           data = cubit.blogs;
//         }
//         return Scaffold(
//           appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Colors.transparent,
//           ),
//           extendBodyBehindAppBar: true,
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Stack(
//                   children: [
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.4,
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                           color: Colors.black26,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Image(
//                         image: NetworkImage("${data[index].image}"),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       left: 0,
//                       child: Container(
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.vertical(
//                               bottom: Radius.circular(10)),
//                           color: Colors.black54,
//                         ),
//                         child: Row(
//                           children: [
//                             Text(
//                               '${data[index].createdAt.substring(0, 10)}',
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 12),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Expanded(
//                               child: Directionality(
//                                 textDirection: TextDirection.rtl,
//                                 child: Text(
//                                   '${data[index].title}',
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 15),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(22),
//                   child: Directionality(
//                     textDirection: TextDirection.rtl,
//                     child: Text(
//                       "${data[index].content}",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:safsofa/cubits/policiesCubit/policies_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/shared/constants.dart';
import '../../../shared/components/custom_app_bar.dart';

class PoliciesDetailsScreen extends StatelessWidget {
  final String? title;
  final int id;

  const PoliciesDetailsScreen({ this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
      ),
      body: BlocProvider(
        create: (context) => PoliciesCubit()..getPolicyDetails(id: id),
        child: BlocConsumer<PoliciesCubit, PoliciesState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return PoliciesCubit.get(context).policyDetails != null
                ? ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${PoliciesCubit.get(context).policyDetails?.data![index].title}",
                          style: TextStyle(
                            color: kDarkGoldColor,
                            fontSize: MediaQuery.of(context).size.width / 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 80,
                        ),
                        Text(
                          "${PoliciesCubit.get(context).policyDetails?.data![index].contentApp}",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 22,
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => Divider(
                      thickness: 1.2,
                      color: Colors.grey.shade400,
                      height: 20,
                    ),
                    itemCount:
                        PoliciesCubit.get(context).policyDetails!.data!.length,
                  )
                : Center(
                    child: CircularProgressIndicator(color: kDarkGoldColor),
                  );
          },
        ),
      ),
    );
  }
}
