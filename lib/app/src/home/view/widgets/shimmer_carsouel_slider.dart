import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/core/extension/media_query.dart';

class ShimmerCarsouelSlider extends StatelessWidget {
  const ShimmerCarsouelSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white10
          : Colors.grey.shade300,
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white24
          : Colors.grey.shade100,
      child: CarouselSlider(
        items: [
          Container(
            width: context.width,
            height: context.height * 0.25,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(
                context.width * 0.05,
              ),
            ),
          ),
          Container(
            width: context.width,
            height: context.height * 0.25,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(
                context.width * 0.05,
              ),
            ),
          ),
          Container(
            width: context.width,
            height: (context.height) / 3,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(
                context.width * 0.05,
              ),
            ),
          ),
        ],
        options: CarouselOptions(
          height: context.height * 0.25,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
          viewportFraction: 1,
        ),
      ),
    );
  }
}
