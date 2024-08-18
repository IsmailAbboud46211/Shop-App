import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/app/global/custom_toast.dart';
import 'package:shop_app/app/global/initial_screen.dart';
import 'package:shop_app/app/src/connection/cubit/internet_connection_cubit.dart';
import 'package:shop_app/app/src/favorites_products/logic/cubit/favorite_product_cubit.dart';
import 'package:shop_app/app/src/favorites_products/view/widgets/favorite_products_list.dart';
import 'package:shop_app/core/enum/toast_state.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/themes/app_color.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteProudctCubit = FavoriteProductCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite Products",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : AppColors.deepBlue,
          ),
        ),
      ),
      body: BlocConsumer<FavoriteProductCubit, FavoriteProductStates>(
        listener: (context, state) {
          if (state is FailedFatchFavoriteProducts) {
            customToast(
              message: state.message,
              state: ToastState.ERROR,
              width: context.width,
            );
          }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! GetFavoriteProductsProgress,
            builder: (context) =>
                BlocConsumer<InternetConnectionCubit, InternetConnectionState>(
                    listener: (context, state) {
              if (state is InternetConnected) {
                favoriteProudctCubit.getFavoriteProducts();
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
            }, builder: (context, state) {
              if (state is InternetDisconnected) {
                return const InitialScreen(
                  iconData: FontAwesomeIcons.wifi,
                  text: "Internet disconnected please check it",
                );
              }
              return favoriteProudctCubit
                      .favoriteProductModel.data.data.isNotEmpty
                  ? FavoriteProductsList(
                      favoriteProductsList:
                          favoriteProudctCubit.favoriteProductModel.data.data,
                    )
                  : const InitialScreen(
                      iconData: FontAwesomeIcons.circleExclamation,
                      text: "No products yet !",
                    );
            }),
            fallback: (context) => FavoriteProductsList(
              favoriteProductsList:
                  favoriteProudctCubit.favoriteProductModel.data.data,
              isShimmerItem: true,
            ),
          );
          /*  },
          ); */
        },
      ),
    );
  }
}
