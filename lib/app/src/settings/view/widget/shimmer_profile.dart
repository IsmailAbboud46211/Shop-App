import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';

class ShimmerProfile extends StatelessWidget {
  const ShimmerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.09),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white10
            : Colors.grey.shade300,
        highlightColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white24
            : Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Shimmer image
            Center(
              child: SizedBox(
                height: (context.height) / 6,
                width: (context.width) / 2.5,
                child: Container(
                  width: (context.width) / 6,
                  height: (context.height) / 6,
                  color: const Color.fromARGB(255, 200, 196, 196),
                ),
              ),
            ),
            (context.width * 0.009).ph,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Shimmer line
                Container(
                  width: (context.width) / 3,
                  height: (context.height) / 60,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(context.width * 0.025),
                    color: const Color.fromARGB(255, 200, 196, 196),
                  ),
                ),
                (context.width * 0.009).ph,
                //Shimmer Line
                Container(
                  width: (context.width) / 3,
                  height: (context.height) / 60,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(context.width * 0.025),
                    color: const Color.fromARGB(255, 200, 196, 196),
                  ),
                ),
                (context.width * 0.009).ph,
                //Shimmer line
                Container(
                  width: (context.width) / 3,
                  height: (context.height) / 60,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(context.width * 0.025),
                    color: const Color.fromARGB(255, 200, 196, 196),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
