import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app/src/FAQS/data/FAQ.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/themes/app_color.dart';

class FAQItem extends StatelessWidget {
  final FAQ faq;
  const FAQItem({required this.faq, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BubbleSpecialThree(
          text: faq.question,
          color: AppColors.primaryColor,
          tail: true,
          textStyle: TextStyle(
            color: AppColors.softGrey,
            fontSize: context.width / 25,
          ),
        ),
        BubbleSpecialThree(
          text: faq.answer,
          color: AppColors.deepBlue,
          tail: true,
          textStyle: TextStyle(
            color: AppColors.softGrey,
            fontSize: context.width / 25,
          ),
          isSender: false,
        ),
      ],
    );
  }
}
