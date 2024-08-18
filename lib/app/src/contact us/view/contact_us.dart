import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/app/global/custom_spinkit.dart';
import 'package:shop_app/app/global/custom_toast.dart';
import 'package:shop_app/app/global/initial_screen.dart';
import 'package:shop_app/app/src/connection/cubit/internet_connection_cubit.dart';
import 'package:shop_app/app/src/contact%20us/logic/cubit/countact_us_cubit.dart';
import 'package:shop_app/app/src/contact%20us/view/widgets/social_account_item.dart';
import 'package:shop_app/core/enum/toast_state.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/themes/app_color.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

List<FaIcon> icons = [
  FaIcon(
    FontAwesomeIcons.facebook,
    color: AppColors.deepBlue,
  ),
  FaIcon(
    FontAwesomeIcons.instagram,
    color: AppColors.pink,
  ),
  FaIcon(
    FontAwesomeIcons.twitter,
    color: AppColors.babyBlue,
  ),
  FaIcon(
    FontAwesomeIcons.google,
    color: AppColors.primaryColor,
  ),
  FaIcon(
    FontAwesomeIcons.phone,
    color: AppColors.grey,
  ),
  FaIcon(
    FontAwesomeIcons.whatsapp,
    color: AppColors.green,
  ),
  FaIcon(
    FontAwesomeIcons.snapchat,
    color: AppColors.yellow,
  ),
  FaIcon(
    FontAwesomeIcons.youtube,
    color: AppColors.red,
  ),
  FaIcon(
    FontAwesomeIcons.webflow,
    color: AppColors.lightGreen,
  ),
];

List<String> titles = [
  "facebook",
  "instagram",
  "twitter",
  "google",
  "phone",
  "whatsapp",
  "snapchat",
  "youtube",
  "web site",
];

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    var contactUsCubit = ContactUsCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact Us",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : AppColors.deepBlue,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(context.width * 0.09),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<ContactUsCubit, ContactUsState>(
                builder: (context, state) => BlocConsumer<
                    InternetConnectionCubit, InternetConnectionState>(
                  listener: (context, state) {
                    if (state is InternetConnected) {
                      contactUsCubit.getContactUsData();
                      customToast(
                        message: "Back to connection",
                        state: ToastState.SUCCESS,
                        width: context.width,
                      );
                    } else if (state is InternetDisconnected) {
                      customToast(
                        message: "Internet disconnected ",
                        state: ToastState.ERROR,
                        width: context.width,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is InternetDisconnected) {
                      return const InitialScreen(
                        iconData: FontAwesomeIcons.wifi,
                        text: "Internet disconnected please check it",
                      );
                    }
                    return ConditionalBuilder(
                      condition:
                          contactUsCubit.contactUsModel.data.data.isNotEmpty,
                      builder: (context) => ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => SocialAccountItem(
                          icon: icons[index],
                          title: titles[index],
                          value: contactUsCubit
                              .contactUsModel.data.data[index].value,
                        ),
                        separatorBuilder: (context, index) => Divider(
                          color: AppColors.lightGrey,
                        ),
                        itemCount:
                            contactUsCubit.contactUsModel.data.data.length,
                      ),
                      fallback: (context) => const CustomSpinkit(),
                    );
                  },
                ),
                listener: (context, state) {
                  if (state is FailedToLoadedContactUs) {
                    customToast(
                      message: state.message,
                      state: ToastState.ERROR,
                      width: context.width,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
