import 'package:flutter/material.dart';

import '../../../../../shared/constants.dart';

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: kDarkGoldColor,
        valueColor:AlwaysStoppedAnimation(kCustomBlack),
      ),
    );
  }
}
