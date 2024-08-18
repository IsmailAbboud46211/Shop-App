import 'package:flutter/material.dart';
import 'package:shop_app/app/src/controlle/logic/cubit/controller_cubit.dart';
import 'package:shop_app/core/themes/app_color.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class ControlleScreen extends StatefulWidget {
  const ControlleScreen({super.key});

  @override
  State<ControlleScreen> createState() => _ControlleScreenState();
}

PageController controller = PageController(initialPage: 2);

class _ControlleScreenState extends State<ControlleScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = ControllerCubit.get(context);
    return Scaffold(
        body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) {
            setState(() {
              cubit.currentIndex = value;
            });
          },
          children: cubit.screensList,
        ),
        bottomNavigationBar: StylishBottomBar(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.softDark
              : AppColors.deepBlue,
          option: AnimatedBarOptions(
              barAnimation: BarAnimation.liquid, iconStyle: IconStyle.animated),
          items: cubit.bottomBarItems,
          currentIndex: cubit.currentIndex,
          onTap: (index) {
            cubit.changeIndex(index: index);
            controller.animateToPage(
              index,
              duration: const Duration(milliseconds: 150),
              curve: Curves.fastEaseInToSlowEaseOut,
            );
          },
        ));
  }
}
