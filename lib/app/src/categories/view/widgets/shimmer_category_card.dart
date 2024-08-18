import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/core/extension/sized_box.dart';

class ShimmerCategoryCard extends StatelessWidget {
  const ShimmerCategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Shimmer.fromColors(
        baseColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white10
            : Colors.grey.shade300,
        highlightColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white24
            : Colors.grey.shade100,
        child: Padding(
          padding: EdgeInsets.all(width * 0.08),
          child: Container(
            color: Colors.white,
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: width / 3.5,
                    height: height / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        width * 0.5,
                      ),
                      color: Colors.white,
                    ),
                  ),
                  (width / 50).pw,
                  Container(
                    width: width / 8,
                    height: height / 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        width * 0.5,
                      ),
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    child: Container(
                      width: width / 15,
                      height: height / 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          width * 0.5,
                        ),
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
