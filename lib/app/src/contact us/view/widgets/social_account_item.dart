import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/app/global/custom_toast.dart';
import 'package:shop_app/core/enum/toast_state.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SocialAccountItem extends StatelessWidget {
  FaIcon icon;
  String title;
  String value;
  SocialAccountItem({
    required this.icon,
    required this.title,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(title),
      onTap: () async {
        final url = Uri.parse(value);
        if (await canLaunchUrl(url)) {
          launchUrl(url);
        } else {
          customToast(
            message: "Sorry there is an issue",
            state: ToastState.ERROR,
            // ignore: use_build_context_synchronously
            width: context.width,
          );
        }
      },
    );
  }
}
