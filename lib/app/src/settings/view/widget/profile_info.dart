import 'package:flutter/material.dart';
import 'package:shop_app/app/global/custom_fancy_image.dart';
import 'package:shop_app/app/global/custom_text.dart';
import 'package:shop_app/core/extension/media_query.dart';

// ignore: must_be_immutable
class ProfileInfo extends StatelessWidget {
  String imageUrl;
  String userName;
  String phoneNumber;
  String email;
  ProfileInfo(
      {required this.email,
      required this.imageUrl,
      required this.phoneNumber,
      required this.userName,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SizedBox(
            height: (context.height) / 6,
            width: (context.width) / 2.5,
            child: CustomFancyShimmerImage(
              imageUrl: imageUrl,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(text: "Name : ", isBold: true),
            CustomText(
              text: userName,
              isBold: false,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(text: "E-mail : ", isBold: true),
            CustomText(
              text: email,
              isBold: false,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(text: "Phone Number : ", isBold: true),
            CustomText(
              text: phoneNumber,
              isBold: false,
            )
          ],
        ),
      ],
    );
  }
}
