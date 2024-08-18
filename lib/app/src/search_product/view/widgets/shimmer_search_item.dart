import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';

class ShimmerSearchProductCard extends StatelessWidget {
  const ShimmerSearchProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all((context.width) / 45),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white10
            : Colors.grey.shade300,
        highlightColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white24
            : Colors.grey.shade100,
        child: SizedBox(
          width: context.width/2.5,
          height: (context.height) / 6,
          child: Row(
            children: [
              // Shimmer Image
              Container(
                color: Colors.white,
                width: (context.width) / 3,
                height: (context.height) / 5,
              ),
              ((context.width) / 50).pw,
              SizedBox(
                width: (context.width) / 2.5,
                height: (context.height) / 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Shimmer Line
                    Container(
                      width: (context.width) / 3,
                      height: (context.height) / 60,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(context.width * 0.025),
                        color: const Color.fromARGB(255, 200, 196, 196),
                      ),
                    ),
                    ((context.height) / 70).ph,
                    // Shimmer Line
                    Container(
                      width: (context.width) / 3,
                      height: (context.height) / 60,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(context.width * 0.025),
                        color: const Color.fromARGB(255, 200, 196, 196),
                      ),
                    ),
                    ((context.height) / 70).ph,
                    // Shimmer price
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
                    Row(
                      children: [
                        // Shimmer favorite icon
                        Container(
                          width: (context.width) / 18,
                          height: (context.height) / 60,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(context.width * 0.025),
                            color: const Color.fromARGB(255, 200, 196, 196),
                          ),
                        ),
                        ((context.width) / 5).pw,
                        // Shimmer info icon
                        Container(
                          width: (context.width) / 25,
                          height: (context.height) / 60,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(context.width * 0.025),
                            color: const Color.fromARGB(255, 200, 196, 196),
                          ),
                        ),
                      ],
                    ),
                    ((context.height) / 70).ph,
                    ((context.width) / 50).pw,
                    // Shimmer boutton
                    Container(
                      width: (context.width) / 4,
                      height: (context.height) / 30,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(context.width * 0.025),
                        color: const Color.fromARGB(255, 200, 196, 196),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
