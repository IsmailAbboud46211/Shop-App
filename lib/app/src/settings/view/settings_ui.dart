// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/app/src/authentication/logic/cubit/log_out_cubit.dart';
import 'package:shop_app/app/src/profile/logic/cubit/profile_cubit.dart';
import 'package:shop_app/app/src/settings/view/widget/profile_info.dart';
import 'package:shop_app/app/src/settings/view/widget/setteing_item.dart';
import 'package:shop_app/app/src/settings/view/widget/settings_group.dart';
import 'package:shop_app/app/src/settings/view/widget/shimmer_profile.dart';
import 'package:shop_app/app/src/start/cubit/start_app_cubit.dart';
import 'package:shop_app/app/global/custom_awesom_dialog.dart';
import 'package:shop_app/app/global/custom_loader_dialog.dart';
import 'package:shop_app/app/global/custom_toast.dart';
import 'package:shop_app/core/database/boxes_names.dart';
import 'package:shop_app/core/database/keys_names.dart';
import 'package:shop_app/core/enum/toast_state.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/routing_extenstion.dart';
import 'package:shop_app/core/router/route_name.dart';
import 'package:shop_app/core/themes/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final startCubit = StartAppCubit.get(context);
    final profileCubit = ProfileCubit.get(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: context.width * 0.09),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<ProfileCubit, ProfileStates>(
                builder: (BuildContext context, state) {
                  if (state is! GetProfileSucceeded) {
                    return const ShimmerProfile();
                  }
                  return ProfileInfo(
                    email: profileCubit.userModel.email,
                    imageUrl: profileCubit.userModel.image,
                    phoneNumber: profileCubit.userModel.phoneNumber,
                    userName: profileCubit.userModel.userName,
                  );
                },
                listener: (BuildContext context, state) {
                  if (state is GetProfileFailed) {
                    customToast(
                      message: state.message,
                      state: ToastState.ERROR,
                      width: context.width,
                    );
                  }
                },
              ),
              SettingsGroup(
                title: "Account",
                settingsItems: [
                  SettingItem(
                    circleColor: AppColors.babyBlue,
                    icon: Icons.edit,
                    title: "Edit pofile",
                    subtitle: "Update your informations ",
                    action: () =>
                        context.go(routeName: RoutesNames.updateProfile),
                  ),
                  BlocProvider(
                    create: (context) => LogOutCubit(),
                    child: BlocConsumer<LogOutCubit, LogOutStates>(
                      listener: (context, state) {
                        if (state is LogOutProgress) {
                          loaderDialogue(context: context);
                        } else if (state is LogOutFailed) {
                          context.pop();
                          customToast(
                            message: "LogOut failed",
                            state: ToastState.ERROR,
                            width: context.width,
                          );
                        } else if (state is LogOutSucceeded) {
                          context.pop();
                          startCubit.kickOutTheUser();
                          customToast(
                            message: "LogOut succeeded",
                            state: ToastState.SUCCESS,
                            width: context.width,
                          );
                          context.go(routeName: RoutesNames.login,replacement: true);
                        }
                      },
                      builder: (context, state) {
                        final logOutCubit = LogOutCubit.get(context);
                        return SettingItem(
                          circleColor: AppColors.sodftRed,
                          icon: Icons.logout_outlined,
                          title: "LogOut",
                          subtitle: "LogOut fromyor profile",
                          action: () => customAwesomeDialog(
                            context: context,
                            title: "Warning",
                            message: "You will logOut are you sure ?",
                            width: context.width,
                            type: DialogType.warning,
                            btnOkColor: AppColors.red,
                            btnCancelColor: AppColors.green,
                            btnCancelText: "Cancel",
                            btnOkText: "Ok",
                            okAction: () => logOutCubit.logOut(),
                            cancelAction: () {},
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const Divider(),
              SettingsGroup(
                title: "General",
                settingsItems: [
                  SettingItem(
                    circleColor: AppColors.lightGrey,
                    icon: Icons.dark_mode,
                    title: "Dark Mode",
                    subtitle: "Change the mode to dark mode",
                    action: () {},
                    trailing: ValueListenableBuilder(
                      valueListenable:
                          Hive.box(BoxesNames.settings).listenable(),
                      builder: (BuildContext context, Box box, Widget? child) {
                        final isDarkMode =
                            box.get(KeysNames.darkMode, defaultValue: false);
                        return Switch(
                          value: isDarkMode,
                          activeColor: AppColors.primaryColor,
                          onChanged: (value) {
                            box.put(KeysNames.darkMode, value);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const Divider(),
              SettingsGroup(
                title: "Contact Us",
                settingsItems: [
                  SettingItem(
                    circleColor: AppColors.grey,
                    icon: Icons.question_mark,
                    title: "FAQs",
                    subtitle: "Find your answers here",
                    action: () => context.go(routeName: RoutesNames.faqs),
                  ),
                  SettingItem(
                    circleColor: AppColors.green,
                    icon: Icons.mail,
                    title: "Contact Us",
                    subtitle: "Here ",
                    action: () => context.go(routeName: RoutesNames.contactUs),
                  ),
                ],
              ),
              const Divider(),
              SettingsGroup(
                title: "Policies",
                settingsItems: [
                  SettingItem(
                    circleColor: AppColors.yellow,
                    icon: Icons.lock,
                    title: "Policies",
                    subtitle: "Check our policies ",
                    action: () => context.go(routeName: RoutesNames.policies),
                  ),
                ],
              ),
              const Divider(),
              SettingsGroup(
                title: "Developer ",
                settingsItems: [
                  SettingItem(
                    circleColor: AppColors.primaryColor,
                    icon: Icons.abc,
                    hasFaIcon: true,
                    faIcon: FaIcon(
                      FontAwesomeIcons.google,
                      color: AppColors.softGrey,
                    ),
                    title: "Mail",
                    subtitle: "Send an e-mail",
                    action: () async {
                      String? encodeQueryParameters(
                          Map<String, String> params) {
                        return params.entries
                            .map((MapEntry<String, String> e) =>
                                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                            .join('&');
                      }

                      final Uri emailUri = Uri(
                        scheme: 'mailto',
                        path: 'ismailtodoapp@gmail.com',
                        query: encodeQueryParameters(
                          <String, String>{
                            'subject': 'Hello from Shop app',
                            'body': "I'am using the app and it's very Good !"
                          },
                        ),
                      );
                      if (await canLaunchUrl(emailUri)) {
                        launchUrl(emailUri);
                      } else {
                        customToast(
                          message:
                              "Sorry , There is an issue , Check your internet connection",
                          state: ToastState.ERROR,
                          width: context.width,
                        );
                      }
                    },
                  ),
                  SettingItem(
                    circleColor: AppColors.pink,
                    icon: Icons.abc,
                    hasFaIcon: true,
                    faIcon: FaIcon(
                      FontAwesomeIcons.instagram,
                      color: AppColors.softGrey,
                    ),
                    title: "Instagram",
                    subtitle: "Find me on instagram",
                    action: () async {
                      final url =
                          Uri.parse('https://www.instagram.com/ismailabboud0');
                      if (await canLaunchUrl(url)) {
                        launchUrl(url);
                      } else {
                        customToast(
                          message:
                              "Sorry , There is an issue , Check your internet connection",
                          state: ToastState.ERROR,
                          width: context.width,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
