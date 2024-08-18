import 'package:flutter/material.dart';
import 'package:shop_app/app/src/FAQS/data/FAQ.dart';
import 'package:shop_app/app/src/FAQS/view/widgets/faq_item.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';
import 'package:shop_app/core/themes/app_color.dart';

class FAQS extends StatefulWidget {
  const FAQS({super.key});

  @override
  State<FAQS> createState() => _FAQSState();
}

List<FAQ> faqsList = [
  FAQ(
      question: "Can I pay upon receipt of the order? ",
      answer:
          "Yes, of course, we only accept traditional payment methods to ensure product delivery and purchase."),
  FAQ(
      question: "What happens if the order does not arrive?",
      answer: "You can contact us on the dedicated page in the settings."),
  FAQ(
      question:
          "Upon receipt of the product, if the product does not match the specifications of the product displayed in the application, can it be returned?",
      answer: "Of course we make sure that doesn't happen, rest assured."),
];

class _FAQSState extends State<FAQS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FAQS",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : AppColors.deepBlue,
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(color: AppColors.deepBlue),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => FAQItem(faq: faqsList[index]),
              itemCount: faqsList.length,
              separatorBuilder: (context, index) => (context.height/20).ph,
            ),
          )
        ],
      ),
    );
  }
}
