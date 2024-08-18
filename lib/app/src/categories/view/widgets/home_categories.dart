import 'package:flutter/material.dart';
import 'package:shop_app/app/src/categories/data/models/data_model.dart';
import 'package:shop_app/app/global/custom_fancy_image.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/themes/app_color.dart';

// ignore: must_be_immutable
class HomeCategoreItem extends StatelessWidget {
  DataModel categoryData;
  HomeCategoreItem({required this.categoryData, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (context.height) / 6,
      width: (context.width) / 2.5,
      child: Stack(
        children: [
          Positioned.fill(
            child: SizedBox(
              height: (context.height) / 12,
              width: (context.width) / 5,
              child: CustomFancyShimmerImage(imageUrl: categoryData.image),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.primaryColor.withAlpha(300),
                    AppColors.primaryColor.withAlpha(150),
                    AppColors.primaryColor
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: (context.width) * 0.02,
            left: (context.width) * 0.02,
            child: SizedBox(
              width: (context.width) * 0.6,
              child: Text(
                categoryData.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
