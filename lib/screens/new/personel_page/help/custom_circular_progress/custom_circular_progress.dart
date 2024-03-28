import 'package:flutter/material.dart';

import '../../../../../shared/constants.dart';

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({Key? key,  this.color=kDarkGoldColor}) : super(key: key);

final Color color;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: color,
        valueColor:AlwaysStoppedAnimation(kCustomBlack),
      ),
    );
  }
}
