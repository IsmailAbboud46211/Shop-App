import 'package:flutter/material.dart';
import 'package:shop_app/app/src/home/data/models/product_model.dart';
import 'package:shop_app/app/src/home/view/widgets/product_card.dart';

// ignore: must_be_immutable
class ProductsGridView extends StatelessWidget {
  List<Product> productsList;
  ProductsGridView({required this.productsList, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
      childAspectRatio: 1 / 1.58,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        productsList.length,
        (index) => ProductCard(product: productsList[index]),
      ),
    );
  }
}
