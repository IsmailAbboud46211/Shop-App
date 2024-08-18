import 'package:flutter/material.dart';
import 'package:shop_app/app/src/categories/data/models/data_model.dart';
import 'package:shop_app/app/src/categories/view/widgets/categorie_card.dart';
import 'package:shop_app/app/src/categories/view/widgets/shimmer_category_card.dart';

// ignore: must_be_immutable
class CategoriesCardList extends StatelessWidget {
  List<DataModel> categoriesList;
  bool shimmerCard;
  CategoriesCardList({
    required this.categoriesList,
    this.shimmerCard = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: height / 8,
      width: width,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => shimmerCard == false
            ? CategoriesCard(
                categoryItem: categoriesList[index],
              )
            : const ShimmerCategoryCard(),
        separatorBuilder: (context, index) => const SizedBox(),
        itemCount: shimmerCard == false ? categoriesList.length : 6,
      ),
    );
  }
}
