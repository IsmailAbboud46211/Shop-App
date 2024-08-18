import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/app/global/custom_toast.dart';
import 'package:shop_app/app/global/initial_screen.dart';
import 'package:shop_app/app/src/cart/logic/cubit/cart_cubit.dart';
import 'package:shop_app/app/src/cart/view/widgets/cart_product_list.dart';
import 'package:shop_app/app/src/connection/cubit/internet_connection_cubit.dart';
import 'package:shop_app/core/enum/toast_state.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/themes/app_color.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var cartCubit = CartCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : AppColors.deepBlue,
          ),
        ),
      ),
      body: BlocConsumer<CartCubit, CartStates>(listener: (context, state) {
        if (state is FailedFatchCartProducts) {
          customToast(
            message: state.message,
            state: ToastState.ERROR,
            width: context.width,
          );
        }
      }, builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetCartProductsProgress,
          builder: (context) =>
              BlocConsumer<InternetConnectionCubit, InternetConnectionState>(
                  listener: (context, state) {
            if (state is InternetConnected) {
              cartCubit.getCartProducts();
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
            return cartCubit.cartModel.data.cartItems.isNotEmpty
                ? CartProductsList(
                    cartProductsList: cartCubit.cartModel.data.cartItems,
                  )
                : const InitialScreen(
                    iconData: FontAwesomeIcons.circleExclamation,
                    text: "No products yet !",
                  );
          }),
          fallback: (context) => CartProductsList(
            cartProductsList: cartCubit.cartModel.data.cartItems,
            isShimmerItem: true,
          ),
        );
      }),
    );
  }
}
