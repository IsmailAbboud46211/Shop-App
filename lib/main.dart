import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/app/src/cart/logic/cubit/cart_cubit.dart';
import 'package:shop_app/app/src/categories/logic/cubit/categories_cubit.dart';
import 'package:shop_app/app/src/connection/cubit/internet_connection_cubit.dart';
import 'package:shop_app/app/src/contact%20us/logic/cubit/countact_us_cubit.dart';
import 'package:shop_app/app/src/controlle/logic/cubit/controller_cubit.dart';
import 'package:shop_app/app/src/favorites_products/logic/cubit/favorite_product_cubit.dart';
import 'package:shop_app/app/src/home/logic/cubit/home_cubit.dart';
import 'package:shop_app/app/src/profile/logic/cubit/profile_cubit.dart';
import 'package:shop_app/app/src/start/cubit/start_app_cubit.dart';
import 'package:shop_app/app_wrapper.dart';
import 'package:shop_app/core/api/api_client.dart';
import 'package:shop_app/core/database/boxes_names.dart';
import 'package:shop_app/core/database/hive_db.dart';
import 'package:shop_app/core/database/keys_names.dart';
import 'package:shop_app/core/router/app_router.dart';
import 'package:shop_app/core/themes/dark_theme.dart';
import 'package:shop_app/core/themes/light_theme.dart';
import 'package:shop_app/logic_observer.dart';

//* global var to access to the DB from anyWhere
HiveDB hiveDB = HiveDB();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //* init the API
  ApiClient apiClient = ApiClient();
  apiClient.dio;
  //* init the local DB
  await hiveDB.initDB();
  //* Router
  AppRouter appRouter = AppRouter();
  //* Cubit Observer
  Bloc.observer = MyBlocObserver();

  runApp(
    ShopApp(
      appRouter: appRouter,
    ),
  );
}

class ShopApp extends StatelessWidget {
  final AppRouter appRouter;
  //* This Key To Access for  app contexts
  static GlobalKey<NavigatorState>? navigatorkey;
  const ShopApp({required this.appRouter, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit()..getHomeData(),
        ),
        BlocProvider<InternetConnectionCubit>(
          create: (context) => InternetConnectionCubit()..checkConnection(),
        ),
        BlocProvider<StartAppCubit>(
          create: (context) => StartAppCubit()..startApp(),
        ),
        BlocProvider<CategoriesCubit>(
          create: (context) => CategoriesCubit()..getCategories(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit()..getCartProducts(),
        ),
        BlocProvider<FavoriteProductCubit>(
          create: (context) => FavoriteProductCubit()..getFavoriteProducts(),
        ),
        BlocProvider<ControllerCubit>(
          create: (context) => ControllerCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit()..getPtofile(),
        ),
        BlocProvider<ContactUsCubit>(
          create: (context) => ContactUsCubit()..getContactUsData(),
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: Hive.box(BoxesNames.settings).listenable(),
        builder: ((BuildContext context, Box box, Widget? child) {
          final isDarkMode = box.get(
            KeysNames.darkMode,
            defaultValue: false,
          );
          return MaterialApp(
            key: navigatorkey,
            title: 'Shop App',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.onGeneratedRoutes,
            theme: isDarkMode
                ? DarkTheme.setDarkMode()
                : LightTheme.setLightMode(),
            home: const AppWrapper(),
          );
        }),
      ),
    );
  }
}
