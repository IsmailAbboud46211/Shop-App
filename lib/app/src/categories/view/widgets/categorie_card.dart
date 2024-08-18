import 'package:flutter/material.dart';
import 'package:shop_app/app/src/categories/data/models/data_model.dart';
import 'package:shop_app/app/global/custom_fancy_image.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';

// ignore: must_be_immutable
class CategoriesCard extends StatefulWidget {
  DataModel categoryItem;
  CategoriesCard({required this.categoryItem, super.key});

  @override
  State<CategoriesCard> createState() => _CategoriesCardState();
}

class _CategoriesCardState extends State<CategoriesCard> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.all(width * 0.08),
      child: Card(
        elevation:10.0 ,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(width * 0.009),
              child: Container(
                width: width / 3.5,
                height: height / 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    width * 0.5,
                  ),
                  color: Colors.grey,
                ),
                child: CustomFancyShimmerImage(
                    imageUrl: widget.categoryItem.image),
              ),
            ),
            (width / 50).pw,
            Text(
              widget.categoryItem.name,
              style: TextStyle(
                //   color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: width / 25,
              ),
            ),
            const Spacer(),
            Padding(
              padding:  EdgeInsets.only(right:context.width*0.009),
              child: const CircleAvatar(
                child: Icon(Icons.arrow_forward_ios_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}
