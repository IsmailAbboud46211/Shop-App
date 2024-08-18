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
import 'package:shop_app/core/extension/routing_extenstion.dart';
import 'package:shop_app/core/themes/app_color.dart';

// ignore: must_be_immutable
class ProductInfo extends StatefulWidget {
  Product product;
  ProductInfo({required this.product, super.key});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    List images = widget.product.images;
    final favoriteProudctCubit = FavoriteProductCubit.get(context);
    final cartCubit = CartCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product info"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: images.length != 1
                  ? GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 1 / 1.36,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                        images.length,
                        (index) => SizedBox(
                          height: (context.height) / 3,
                          width: context.width,
                          child: CustomFancyShimmerImage(
                            imageUrl: images[index],
                          ),
                        ),
                      ),
                    )
                  : CustomFancyShimmerImage(
                      imageUrl: images[0],
                    ),
            ),
            Padding(
              padding: EdgeInsets.all(context.height * 0.025),
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      "Product's name : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(widget.product.name),
                  ),
                  ListTile(
                    title: const Text(
                      "Product's description : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(widget.product.description),
                  ),
                  Visibility(
                    visible: widget.product.discount != 0,
                    child: ListTile(
                      title: const Text(
                        "Product's old price: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "${widget.product.oldPrice.toString()}\$",
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "Product's price : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${widget.product.price.toString()}\$",
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocConsumer<CartCubit, CartStates>(
                        listener: (context, state) {
                          if (state is FailedToggledCartProductState) {
                            customToast(
                              message: state.message,
                              state: ToastState.ERROR,
                              width: context.width,
                            );
                            context.pop();
                          } else if (state
                              is CartProductStateToggledSuccessfully) {
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
                              child: cartCubit
                                          .cartProdutsID[widget.product.id] ==
                                      true
                                  ? ElevatedButton.icon(
                                      onPressed: () =>
                                          cartCubit.toggoleCartProduct(
                                              productID: widget.product.id),
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
                                      onPressed: () =>
                                          cartCubit.toggoleCartProduct(
                                              productID: widget.product.id),
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
                                productID: widget.product.id,
                              );
                            },
                            icon: favoriteProudctCubit
                                        .favoriteProdutsID[widget.product.id] ==
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
