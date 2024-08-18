import 'package:flutter/material.dart';
import 'package:shop_app/app/global/custom_shimmer_product_card.dart';
import 'package:shop_app/app/src/cart/data/cart_model.dart';
import 'package:shop_app/app/src/cart/view/widgets/cart_product_card.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';

// ignore: must_be_immutable
class CartProductsList extends StatelessWidget {
  List<CartItems>? cartProductsList;
  bool isShimmerItem;
  CartProductsList({
    required this.cartProductsList,
    this.isShimmerItem = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => isShimmerItem == false
          ?  CartProductCard(
              cartProductData: cartProductsList![index].product!,
            )
          : const CustomShimmerProductCard(isFavoriteProductCard: false),
      separatorBuilder: (context, index) => ((context.width) / 75).ph,
      itemCount: isShimmerItem == false ? cartProductsList!.length : 10,
    );
  }
}
