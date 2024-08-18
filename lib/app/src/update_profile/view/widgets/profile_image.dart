import 'package:flutter/material.dart';
import 'package:shop_app/app/global/custom_fancy_image.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/themes/app_color.dart';

// ignore: must_be_immutable
class ProfileImage extends StatelessWidget {
  String imageUrl;
  ProfileImage({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          width: context.width,
          height: (context.height) / 5,
          color: AppColors.primaryColor,
        ),
        CircleAvatar(
          radius: context.width / 5,
          child: CustomFancyShimmerImage(
            imageUrl: imageUrl,
          ),
        )
      ],
    );
  }
}
