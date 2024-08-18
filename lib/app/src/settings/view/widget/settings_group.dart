import 'package:flutter/material.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/themes/app_color.dart';

class SettingsGroup extends StatelessWidget {
  final String title;
  final List<Widget> settingsItems;
  const SettingsGroup(
      {required this.title, required this.settingsItems, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.width / 40,
        right: context.width / 30,
        left: context.width / 30,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: context.width / 25,
              ),
            ),
          ),
          //  List.generate(settingsItems.length, (index) =>(){} ),
          ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => settingsItems[index],
            separatorBuilder: (context, index) => const Divider(),
            itemCount: settingsItems.length,
          )
        ],
      ),
    );
  }
}
