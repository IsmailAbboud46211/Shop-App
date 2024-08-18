import 'package:flutter/material.dart';
import 'package:shop_app/app/src/search_product/data/model/search_model.dart';
import 'package:shop_app/app/src/search_product/view/widgets/search_product_card.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';

// ignore: must_be_immutable
class SearchProductsList extends StatelessWidget {
  List<SearchProduct>? searchProductsList;

  SearchProductsList({
    required this.searchProductsList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => SearchProductCard(
        searchProduct: searchProductsList![index],
      ),
      separatorBuilder: (context, index) => (context.width * 0.024).pw,
      itemCount:
          searchProductsList!.isNotEmpty ? searchProductsList!.length : 10,
    );
  }
}
