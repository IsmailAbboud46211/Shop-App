import 'package:flutter/material.dart';
import 'package:shop_app/app/src/categories/data/models/data_model.dart';
import 'package:shop_app/app/src/categories/view/widgets/home_categories.dart';
import 'package:shop_app/core/extension/sized_box.dart';

// ignore: must_be_immutable
class CategoriesListView extends StatefulWidget {
  List<DataModel> categoriesList;
  CategoriesListView({required this.categoriesList, super.key});

  @override
  State<CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
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
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>
            HomeCategoreItem(categoryData: widget.categoriesList[index]),
        separatorBuilder: (context, index) => (width * 0.05).pw,
        itemCount: widget.categoriesList.length,
      ),
    );
  }
}
