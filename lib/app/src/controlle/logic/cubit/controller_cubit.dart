import 'package:shop_app/app/src/cart/view/cart_ui.dart';
import 'package:shop_app/core/themes/app_color.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app/src/categories/view/categories_ui.dart';
import 'package:shop_app/app/src/favorites_products/view/favorite_ui.dart';
import 'package:shop_app/app/src/home/view/home_ui.dart';
import 'package:shop_app/app/src/settings/view/settings_ui.dart';

part 'controller_state.dart';

class ControllerCubit extends Cubit<ControllerState> {
  ControllerCubit() : super(ControllerInitial());
  static ControllerCubit get(context) => BlocProvider.of(context);

  List<Widget> screensList = [
    const FavoriteScreen(),
    const CartScreen(),
    const HomeScreen(),
    const CategoriesScreen(),
    const SettingsScreen(),
  ];

  List<BottomBarItem> bottomBarItems = [
    BottomBarItem(
      icon: const Icon(Icons.favorite),
      title: const Text('Favorite'),
      backgroundColor:AppColors.sodftRed,
    ),
    BottomBarItem(
      icon: const Icon(Icons.shopping_cart),
      title: const Text('Cart'),
      backgroundColor:AppColors.softGrey,
    ),
    BottomBarItem(
      icon: const Icon(Icons.home),
      title: const Text('Home'),
      backgroundColor:AppColors.primaryColor,
    ),
    BottomBarItem(
      icon: const Icon(Icons.category),
      title: const Text('Category'),
      backgroundColor:AppColors.grey,
    ),
    BottomBarItem(
      icon: const Icon(Icons.settings),
      title: const Text('Settings'),
      backgroundColor: AppColors.lightGreen,
    ),
  ];
  var currentIndex = 2;

  void changeIndex({required int index}) {
    currentIndex = index;
  }

}
