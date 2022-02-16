import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatelessWidget {
  const CustomRatingBar({
    Key key,
    this.rating,
    this.itemSize = 15,
  }) : super(key: key);

  final double rating;
  final double itemSize;
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rating,
      minRating: 1,
      itemSize: itemSize,
      direction: Axis.horizontal,
      allowHalfRating: false,
      updateOnDrag: false,
      glow: false,
      ignoreGestures: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Color(0xffFFCF00),
      ),
    );
  }
}
