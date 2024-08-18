import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/themes/app_color.dart';

class SettingItem extends StatelessWidget {
  final Color circleColor;
  final IconData icon;
  final  bool hasFaIcon;
  final FaIcon? faIcon;
  final String title;
  final String subtitle;
  final Function() action;
  final Widget? trailing;

  const SettingItem({
    required this.circleColor,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.action,
    this.hasFaIcon=false,
    this.faIcon,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: circleColor,
        maxRadius: (context.width) * 0.05,
        child:hasFaIcon==false? Icon(
          icon,
          color: Colors.white,
        ):faIcon,
      ),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: AppColors.grey,
          fontSize: 12,
        ),
      ),
      onTap: action,
      trailing: trailing,
    );
  }
}
