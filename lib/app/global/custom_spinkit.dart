import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';
import 'package:shop_app/core/themes/app_color.dart';

class CustomSpinkit extends StatelessWidget {
  const CustomSpinkit({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (context.height / 5).ph,
        Center(
          child: SpinKitFadingCircle(
            color: AppColors.primaryColor,
            size: context.width * 0.15,
          ),
        )
      ],
    );
  }
}
