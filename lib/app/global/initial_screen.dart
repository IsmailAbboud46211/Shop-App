import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';
import 'package:shop_app/core/themes/app_color.dart';

class InitialScreen extends StatelessWidget {
  final String text;
  final IconData iconData;
  const InitialScreen({
    required this.iconData,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (context.height / 3).ph,
          FaIcon(
            iconData,
            color: AppColors.primaryColor,
            size: context.width / 6,
          ),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : AppColors.deepBlue,
            ),
          ),
        ],
      ),
    );
  }
}
