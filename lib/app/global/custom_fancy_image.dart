import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/images.dart';

class CustomFancyShimmerImage extends StatelessWidget {
  final String imageUrl;
  const CustomFancyShimmerImage({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return FancyShimmerImage(
      imageUrl: imageUrl,
      shimmerBaseColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white10
          : Colors.grey.shade300,
      shimmerHighlightColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white24
          : Colors.grey.shade100,
      errorWidget: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            width * 0.05,
          ),
          image: DecorationImage(
            image: Image.asset(Images.noImage).image,
            fit: BoxFit.fill,
          ),
        ),
      ),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
          ),
          color: Colors.white,
        ),
      ),
      boxDecoration: BoxDecoration(
        color: Colors.grey.shade300,
      ),
    );
  }
}
