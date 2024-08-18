import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app/src/favorites_products/data/model/favorite_product_model.dart';
import 'package:shop_app/app/src/favorites_products/logic/cubit/favorite_product_cubit.dart';
import 'package:shop_app/app/src/home/logic/cubit/home_cubit.dart';

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
class FavoriteProductCard extends StatefulWidget {
  FavoriteProductData favoriteProductData;
  FavoriteProductCard({required this.favoriteProductData, super.key});

  @override
  State<FavoriteProductCard> createState() => _FavoriteProductCardState();
}

class _FavoriteProductCardState extends State<FavoriteProductCard> {
  // ignore: prefer_typing_uninitialized_variables
  var product;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);
    var listOfProducts = homeCubit.homeModel.data.productsList;
    for (var productItem in listOfProducts) {
      if (productItem.id == widget.favoriteProductData.product!.id) {
        product = productItem;
      }
    }
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.bottomLeft, children: [
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
                child: CustomFancyShimmerImage(
                  imageUrl: widget.favoriteProductData.product!.image!,
                ),
              ),
            ),
            Visibility(
              visible: widget.favoriteProductData.product!.discount != 0,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.width * 0.025),
                child: Container(
                  width: (context.width) / 6,
                  height: (context.height) / 40,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      "DISCOUNT",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: (context.width) / 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
          (context.width / 50).pw,
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: context.width * 0.009),
              child: SizedBox(
                width: context.width,
                height: (context.height) / 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.favoriteProductData.product!.name!,
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
                          '${widget.favoriteProductData.product!.price.round()}\$',
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
                                  productID:
                                      widget.favoriteProductData.product!.id!,
                                );
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: AppColors.pink,
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
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
