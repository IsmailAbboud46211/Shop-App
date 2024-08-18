import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';

class ShimmerHomeProductCard extends StatelessWidget {
  const ShimmerHomeProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white10
          : Colors.grey.shade300,
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white24
          : Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Shimmer image
          SizedBox(
            height: (context.height) / 6,
            width: context.width,
            child: Container(
              width: context.width,
              height: (context.height) / 6,
              color: const Color.fromARGB(255, 200, 196, 196),
            ),
          ),
          (context.width * 0.009).ph,
          Padding(
            padding: EdgeInsets.only(
              top: context.width * 0.04,
              right: context.width * 0.025,
              left: context.width * 0.04,
              bottom: context.width * 0.002,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Shimmer line
                Container(
                  width: (context.width) / 2.5,
                  height: (context.height) / 60,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(context.width * 0.025),
                    color: const Color.fromARGB(255, 200, 196, 196),
                  ),
                ),
                ((context.height) / 70).ph,
                //Shimmer Line
                Container(
                  width: (context.width) / 2.5,
                  height: (context.height) / 60,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(context.width * 0.025),
                    color: const Color.fromARGB(255, 200, 196, 196),
                  ),
                ),
                ((context.height) / 70).ph,
                //Shimmer price
                Container(
                  width: (context.width) / 8,
                  height: (context.height) / 60,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(context.width * 0.025),
                    color: const Color.fromARGB(255, 200, 196, 196),
                  ),
                ),
                ((context.height) / 70).ph,
                Padding(
                  padding: EdgeInsets.zero,
                  child: Row(
                    children: [
                      //Shimmer favorite icon
                      Container(
                        width: (context.width) / 25,
                        height: (context.height) / 60,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(context.width * 0.025),
                          color: const Color.fromARGB(255, 200, 196, 196),
                        ),
                      ),
                      const Spacer(),
                      //Shimmer info icon
                      Container(
                        width: (context.width) / 30,
                        height: (context.height) / 60,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular((context.width) * 0.025),
                          color: const Color.fromARGB(255, 200, 196, 196),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: (context.width) / 4,
                    height: (context.height) / 30,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(context.width * 0.025),
                      color: const Color.fromARGB(255, 200, 196, 196),
                    ),
                  ),
                ),
              ],
              // Shimmer boutton
            ),
          )
        ],
      ),
    );
  }
}
