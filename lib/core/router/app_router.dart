import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app/src/FAQS/view/FAQS.dart';
import 'package:shop_app/app/src/authentication/view/log_in_ui.dart';
import 'package:shop_app/app/src/authentication/view/register_ui.dart';
import 'package:shop_app/app/src/authentication/logic/cubit/register_cubit.dart';
import 'package:shop_app/app/src/authentication/logic/cubit/login_cubit.dart';
import 'package:shop_app/app/src/cart/view/cart_ui.dart';
import 'package:shop_app/app/src/contact%20us/view/contact_us.dart';
import 'package:shop_app/app/src/controlle/view/controlle_ui.dart';
import 'package:shop_app/app/src/home/data/models/product_model.dart';
import 'package:shop_app/app/src/on_bording/view/on_bording_ui.dart';
import 'package:shop_app/app/src/policies/view/policies_ui.dart';
import 'package:shop_app/app/src/search_product/view/search_ui.dart';
import 'package:shop_app/app/src/update_profile/view/update_profile_ui.dart';
import 'package:shop_app/app/src/view_product/view/product_info_ui.dart';
import 'package:shop_app/core/router/route_name.dart';

class AppRouter {
  Route? onGeneratedRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.onBoaring:
        return MaterialPageRoute(
          builder: (_) => const OnBordingScreen(),
        );

      case RoutesNames.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LogInCubit>(
            create: (context) => LogInCubit(),
            child: const LogInScreen(),
          ),
        );

      case RoutesNames.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<RegisterCubit>(
            create: (context) => RegisterCubit(),
            child: const RegisterScreen(),
          ),
        );

      case RoutesNames.home:
        return MaterialPageRoute(
          builder: (_) => const ControlleScreen(),
        );

      case RoutesNames.productInfo:
        return MaterialPageRoute(
          builder: (_) => ProductInfo(product: settings.arguments as Product),
        );

      case RoutesNames.policies:
        return MaterialPageRoute(
          builder: (_) => const Policies(),
        );

      case RoutesNames.updateProfile:
        return MaterialPageRoute(
          builder: (_) => const UpdateProfile(),
        );

      case RoutesNames.search:
        return MaterialPageRoute(
          builder: (_) => const SearchProductScreen(),
        );

      case RoutesNames.faqs:
        return MaterialPageRoute(
          builder: (_) => const FAQS(),
        );

      case RoutesNames.contactUs:
        return MaterialPageRoute(
          builder: (_) => const ContactUs(),
        );

      case RoutesNames.cart:
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
        );
    }

    return null;
  }
}
