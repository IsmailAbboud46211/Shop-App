import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app/src/categories/data/models/data_model.dart';
import 'package:shop_app/app/src/categories/view/widgets/categories_card_list.dart';

// ignore: must_be_immutable
class BuildCategoriesConditionalBuilder extends StatelessWidget {
  List<DataModel> categoriesList;
  BuildCategoriesConditionalBuilder({required this.categoriesList, super.key});

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: categoriesList.isNotEmpty,
      builder: (context) => CategoriesCardList(categoriesList: categoriesList),
      fallback: (context) => CategoriesCardList(
        categoriesList: const [],
        shimmerCard: true,
      ),
    );
  }
}
