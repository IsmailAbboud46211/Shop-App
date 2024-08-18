import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/app/global/initial_screen.dart';
import 'package:shop_app/app/src/categories/logic/cubit/categories_cubit.dart';
import 'package:shop_app/app/src/categories/view/widgets/categories_conditional_builder.dart';
import 'package:shop_app/app/src/connection/cubit/internet_connection_cubit.dart';
import 'package:shop_app/app/src/home/logic/cubit/home_cubit.dart';
import 'package:shop_app/app/src/home/view/widgets/carosuel_slider_conditonal_builder.dart';
import 'package:shop_app/app/src/home/view/widgets/products_conditonal_builder.dart';
import 'package:shop_app/app/global/custom_toast.dart';
import 'package:shop_app/core/enum/toast_state.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';
import 'package:shop_app/core/extension/routing_extenstion.dart';
import 'package:shop_app/core/router/route_name.dart';
import 'package:shop_app/core/themes/app_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);
    final categoryCubit = CategoriesCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (context, state) => RefreshIndicator(
        onRefresh: () async => homeCubit.getHomeData(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Shop App",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : AppColors.deepBlue,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => context.go(routeName: RoutesNames.search),
                icon: const Icon(Icons.search),
              )
            ],
          ),
          body: BlocConsumer<InternetConnectionCubit, InternetConnectionState>(
            builder: (context, state) {
              if (state is InternetDisconnected) {
                return const InitialScreen(
                  iconData: FontAwesomeIcons.wifi,
                  text: "Internet disconnected please check it",
                );
              }
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildCarsouelCondtionalBuilder(
                      bannersList: homeCubit.homeModel.data.bannersList,
                    ),
                    (context.height * 0.005).ph,
                    Padding(
                      padding: EdgeInsets.all(context.width * 0.02),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: context.width * 0.04,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : AppColors.deepBlue,
                        ),
                      ),
                    ),
                    (context.height * 0.005).ph,
                    BuildHomeCategoriesConditionalBuilder(
                      categoriesList: categoryCubit
                          .categoriesModel.categoriesDataModel.data,
                    ),
                    (context.height * 0.005).ph,
                    Padding(
                      padding: EdgeInsets.all(context.width * 0.02),
                      child: Text(
                        "New Products",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: context.width * 0.04,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : AppColors.deepBlue,
                        ),
                      ),
                    ),
                    (context.height * 0.005).ph,
                    BuildProductsCondtionalBuilder(
                      productsList: homeCubit.homeModel.data.productsList,
                    ),
                  ],
                ),
              );
            },
            listener: (BuildContext context, InternetConnectionState state) {
              if (state is InternetConnected) {
                homeCubit.getHomeData();
                customToast(
                  message: "Online",
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
          ),
        ),
      ),
      listener: (context, state) {
        if (state is FailedToFetchData) {
          customToast(
            message: state.message,
            state: ToastState.ERROR,
            width: context.width,
          );
        }
      },
    );
  }
}
