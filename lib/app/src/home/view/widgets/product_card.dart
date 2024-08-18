import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app/src/cart/logic/cubit/cart_cubit.dart';
import 'package:shop_app/app/src/favorites_products/logic/cubit/favorite_product_cubit.dart';
import 'package:shop_app/app/src/home/data/models/product_model.dart';
import 'package:shop_app/app/global/custom_fancy_image.dart';
import 'package:shop_app/app/global/custom_loader_dialog.dart';
import 'package:shop_app/app/global/custom_toast.dart';
import 'package:shop_app/core/enum/toast_state.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';
import 'package:shop_app/core/extension/routing_extenstion.dart';
import 'package:shop_app/core/router/route_name.dart';
import 'package:shop_app/core/themes/app_color.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  Product product;
  ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProudctCubit = FavoriteProductCubit.get(context);
    final cartCubit = CartCubit.get(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: (context.height) / 6,
                width: context.width,
                color: Colors.white,
                child: CustomFancyShimmerImage(
                  imageUrl: product.image,
                ),
              ),
              Visibility(
                visible: product.discount != 0,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.width * 0.025),
                  child: Container(
                    width: (context.width) / 8,
                    height: (context.height) / 50,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        "DISCOUNT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: (context.width) / 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: context.width * 0.04,
              right: context.width * 0.025,
              left: context.width * 0.04,
              bottom: context.width * 0.002,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                (context.width * 0.009).ph,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${product.price.round()}\$',
                      style: TextStyle(color: AppColors.green),
                    ),
                    (context.width * 0.05).pw,
                    Visibility(
                      visible: product.discount != 0,
                      child: Text(
                        '${product.oldPrice.round()}\$',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: product.name.length < 25,
                  child: (context.width / 20).ph,
                ),
                Row(
                  children: [
                    BlocConsumer<FavoriteProductCubit, FavoriteProductStates>(
                      listener: (context, state) {
                        if (state is FailedToggledFavoriteProduct) {
                          customToast(
                            message: state.message,
                            state: ToastState.ERROR,
                            width: context.width,
                          );
                          context.pop();
                        } else if (state
                            is FavoriteProductToggledSuccessfully) {
                          context.pop();
                        } else if (state is ToggleFavoriteProductProgress) {
                          loaderDialogue(context: context);
                        }
                      },
                      builder: (context, state) {
                        if (state is FavoriteProductToggledSuccessfully) {
                          favoriteProudctCubit.getFavoriteProducts();
                        }
                        return IconButton(
                          onPressed: () {
                            favoriteProudctCubit.toggleProductFavorits(
                              productID: product.id,
                            );
                          },
                          icon: favoriteProudctCubit
                                      .favoriteProdutsID[product.id] ==
                                  true
                              ? Icon(
                                  Icons.favorite,
                                  color: AppColors.pink,
                                )
                              : Icon(
                                  Icons.favorite_border_outlined,
                                  color: AppColors.grey,
                                ),
                        );
                      },
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => context.go(
                        routeName: RoutesNames.productInfo,
                        arguments: product,
                        replacement: false,
                      ),
                      icon: const Icon(
                        Icons.info,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
                BlocConsumer<CartCubit, CartStates>(
                  listener: (context, state) {
                    if (state is FailedToggledCartProductState) {
                      customToast(
                        message: state.message,
                        state: ToastState.ERROR,
                        width: context.width,
                      );
                      context.pop();
                    } else if (state is CartProductStateToggledSuccessfully) {
                      context.pop();
                    } else if (state is ToggleCartProductStateProgress) {
                      loaderDialogue(context: context);
                    }
                  },
                  builder: (context, state) {
                    if (state is CartProductStateToggledSuccessfully) {
                      cartCubit.getCartProducts();
                    }
                    return Center(
                        child: cartCubit.cartProdutsID[product.id] == true
                            ? ElevatedButton.icon(
                                onPressed: () => cartCubit.toggoleCartProduct(
                                    productID: product.id),
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.white,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                ),
                                label: Text(
                                  "Remove Order",
                                  style: TextStyle(
                                    fontSize: context.width / 35,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : ElevatedButton.icon(
                                onPressed: () => cartCubit.toggoleCartProduct(
                                    productID: product.id),
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: AppColors.primaryColor,
                                ),
                                label: Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                    fontSize: context.width / 35,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
