import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app/src/home/data/models/banner_model.dart';
import 'package:shop_app/app/src/home/view/widgets/carosuel_slider.dart';
import 'package:shop_app/app/src/home/view/widgets/shimmer_carsouel_slider.dart';

// ignore: must_be_immutable
class BuildCarsouelCondtionalBuilder extends StatelessWidget {
  List<BannerModel> bannersList;
  BuildCarsouelCondtionalBuilder({required this.bannersList, super.key});

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: bannersList.isNotEmpty,
      builder: (context) => BuildCarouselSlider(
        bannersList: bannersList,
      ),
      fallback: (context) => const ShimmerCarsouelSlider(),
    );
  }
}
