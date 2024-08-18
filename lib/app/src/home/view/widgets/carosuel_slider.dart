import 'package:carousel_slider/carousel_slider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app/src/home/data/models/banner_model.dart';
import 'package:shop_app/core/extension/media_query.dart';

// ignore: must_be_immutable
class BuildCarouselSlider extends StatelessWidget {
  List<BannerModel> bannersList;
  BuildCarouselSlider({required this.bannersList, super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: bannersList
          .map(
            (BannerModel banner) => FancyShimmerImage(
              imageUrl: banner.image,
              width: context.width,
              shimmerBaseColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white10
                  : Colors.grey.shade300,
              shimmerHighlightColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white24
                      : Colors.grey.shade100,
              errorWidget: Container(
                width: context.width,
                height: (context.height) / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    context.width * 0.05,
                  ),
                  image: DecorationImage(
                    image: Image.asset('assets/no-image.png').image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              imageBuilder: (context, imageProvider) => Container(
                width: context.width,
                height: context.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    context.width * 0.05,
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              boxDecoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(
                  context.width * 0.05,
                ),
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: context.height * 0.25,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(seconds: 1),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
        viewportFraction: 1,
      ),
    );
  }
}
