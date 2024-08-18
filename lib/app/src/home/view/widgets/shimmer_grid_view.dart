import 'package:flutter/material.dart';
import 'package:shop_app/app/src/home/view/widgets/shimmer_product_card.dart';

class ShimmerGridView extends StatelessWidget {
  const ShimmerGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
      childAspectRatio: 1 / 1.36,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        6,
        (index) => const ShimmerHomeProductCard(),
      ),
    );
  }
}
