
import 'package:flutter/material.dart';

import '../cubits/technicalSupporDetailstCubit/technical_suppor_detailst_cubit.dart';
import '../cubits/technicalSupporDetailstCubit/technical_suppor_detailst_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/src/public_ext.dart';
import '../shared/components/custom_app_bar.dart';
class TechnicalSupporDetailstScreen extends StatelessWidget {
  const TechnicalSupporDetailstScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<TechnicalSupportDetailsCubit, TechnicalSupportDetailstState>(
      builder: (context, state) {
        TechnicalSupportDetailsCubit cubit = TechnicalSupportDetailsCubit.get(context);
        state is TechnicalSupportdetailstInitial ? cubit.getTechnicalSupport():print("getdata");

        return Scaffold(
          appBar: CustomAppBar(
            title: 'TechnicalSupport'.tr(),
          ),
          body: state is!     GetTechnicalSupportdetailstSuccessState?Center(child: CircularProgressIndicator(),):Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

              ],
            ),
          ),
        );

      },
    );







  }
}