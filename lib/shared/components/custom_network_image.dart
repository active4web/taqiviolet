

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart%20';
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final BorderRadiusGeometry? border;

  const CustomNetworkImage({
    Key? key,
    required this.image,
    this.width = double.infinity,
    this.height = 180,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: border,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),

      ///=== is dark baseColor = grey[800]! & hightLightColor = grey[850]! ===///
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: border,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      height: height,
      fit: BoxFit.cover,
      width: width,
    );
  }
}
