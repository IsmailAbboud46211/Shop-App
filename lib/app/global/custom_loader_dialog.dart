import 'package:flutter/material.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/themes/app_color.dart';

void loaderDialogue({
  required BuildContext context,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Theme.of(context).brightness == Brightness.dark
        ? Colors.black12.withAlpha(10)
        : Colors.white.withAlpha(10),
    builder: (
      context,
    ) =>
        PopScope(
      child: AlertDialog(
        shadowColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: Container(
          width: (context.width) / 4,
          height: (context.height) / 5,
          decoration: BoxDecoration(
            color: AppColors.deepBlue,
            borderRadius: BorderRadius.circular(
              context.width * 0.05,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircularProgressIndicator(),
                Text(
                  "Progress",
                  style: TextStyle(color: AppColors.softWhite),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
