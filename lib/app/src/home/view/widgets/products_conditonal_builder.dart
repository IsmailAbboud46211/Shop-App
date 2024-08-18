import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app/src/home/data/models/product_model.dart';
import 'package:shop_app/app/src/home/view/widgets/products_grid_view.dart';
import 'package:shop_app/app/src/home/view/widgets/shimmer_grid_view.dart';

// ignore: must_be_immutable
class BuildProductsCondtionalBuilder extends StatelessWidget {
  List<Product> productsList;
  BuildProductsCondtionalBuilder({required this.productsList, super.key});

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: productsList.isNotEmpty,
      builder: (context) => ProductsGridView(
        productsList: productsList,
      ),
      fallback: (context) => const ShimmerGridView(),
    );
  }
}
