import 'package:flutter/material.dart';
import 'package:shop_app/app/global/custom_shimmer_product_card.dart';
import 'package:shop_app/app/src/favorites_products/data/model/favorite_product_model.dart';
import 'package:shop_app/app/src/favorites_products/view/widgets/favorite_product_card.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';

// ignore: must_be_immutable
class FavoriteProductsList extends StatelessWidget {
  List<FavoriteProductData>? favoriteProductsList;
  bool isShimmerItem;
  FavoriteProductsList({
    required this.favoriteProductsList,
    this.isShimmerItem = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => isShimmerItem == false
          ? FavoriteProductCard(
              favoriteProductData: favoriteProductsList![index],
            )
          : const CustomShimmerProductCard(isFavoriteProductCard: true),
      separatorBuilder: (context, index) => ((context.width) / 75).ph,
      itemCount: isShimmerItem == false ? favoriteProductsList!.length : 10,
    );
  }
}
