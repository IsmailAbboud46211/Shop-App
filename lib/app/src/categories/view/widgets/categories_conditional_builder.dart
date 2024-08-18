import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app/src/categories/data/models/data_model.dart';
import 'package:shop_app/app/src/categories/view/widgets/categories_list.dart';
import 'package:shop_app/app/src/categories/view/widgets/shimmer_home_category.dart';

// ignore: must_be_immutable
class BuildHomeCategoriesConditionalBuilder extends StatelessWidget {
  List<DataModel> categoriesList;
  BuildHomeCategoriesConditionalBuilder(
      {required this.categoriesList, super.key});

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: categoriesList.isNotEmpty,
      builder: (context) => CategoriesListView(categoriesList: categoriesList),
      fallback: (context) => const ShimmerHomeCategory(),
    );
  }
}
