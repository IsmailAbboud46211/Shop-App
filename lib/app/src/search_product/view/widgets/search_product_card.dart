import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app/src/favorites_products/logic/cubit/favorite_product_cubit.dart';
import 'package:shop_app/app/src/home/logic/cubit/home_cubit.dart';
import 'package:shop_app/app/src/search_product/data/model/search_model.dart';
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
class SearchProductCard extends StatelessWidget {
  SearchProduct searchProduct;
  SearchProductCard({required this.searchProduct, super.key});
  // ignore: prefer_typing_uninitialized_variables
  var product;

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);
    final favoriteProudctCubit = FavoriteProductCubit.get(context);
    var listOfProducts = homeCubit.homeModel.data.productsList;
    for (var productItem in listOfProducts) {
      if (productItem.id == searchProduct.id) {
        product = productItem;
      }
    }
    return SizedBox(
      child: Card(
        elevation: 20,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: (context.width) / 2,
              height: (context.height) / 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  context.width * 0.5,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(context.width / 75),
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: CustomFancyShimmerImage(
                    imageUrl: searchProduct.image,
                  ),
                ),
              ),
            ),
            (context.width / 50).pw,
            Expanded(
              child: SizedBox(
                width: context.width,
                height: (context.height) / 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      searchProduct.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${searchProduct.price.round()}\$',
                          style: TextStyle(color: AppColors.green),
                        ),
                        (context.width * 0.05).pw,
                      ],
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocConsumer<FavoriteProductCubit,
                            FavoriteProductStates>(
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
                              FavoriteProductCubit.get(context)
                                  .getFavoriteProducts();
                            }
                            return IconButton(
                              onPressed: () {
                                FavoriteProductCubit.get(context)
                                    .toggleProductFavorits(
                                  productID: searchProduct.id,
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
                          onPressed: () {
                            context.go(
                              routeName: RoutesNames.productInfo,
                              arguments: product,
                              replacement: false,
                            );
                          },
                          icon: const Icon(
                            Icons.info,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    /*   Center(
                      child: product.inCart != true
                          ? ElevatedButton.icon(
                              onPressed: () {},
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
                            )
                          : ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.remove_circle,
                                color: Colors.white,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                              ),
                              label: Text(
                                "Remove from cart",
                                style: TextStyle(
                                  fontSize: context.width / 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),*/
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
