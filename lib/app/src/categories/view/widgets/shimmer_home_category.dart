import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';

class ShimmerHomeCategory extends StatelessWidget {
  const ShimmerHomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white10
          : Colors.grey.shade300,
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white24
          : Colors.grey.shade100,
      child: SizedBox(
        height: (context.height) / 8,
        width: context.width,
        child: ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
            height: (context.height) / 6,
            width: (context.width) / 2.5,
            decoration:const BoxDecoration(
              color: Colors.white,
            ),
          ),
          separatorBuilder: (context, index) => ((context.width) * 0.05).pw,
          itemCount: 5,
        ),
      ),
    );
  }
}
