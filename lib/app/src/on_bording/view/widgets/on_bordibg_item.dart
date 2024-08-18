import 'package:flutter/material.dart';
import 'package:shop_app/app/src/on_bording/data/model/on_bording_model.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';

class OnBordingSingleScreen extends StatelessWidget {
  final BoardModel boardModel;
  const OnBordingSingleScreen({required this.boardModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (context.height * 0.05).ph,
        Container(
          width: context.width,
          height: (context.height) / 2.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              context.width * 0.05,
            ),
            image: DecorationImage(
              image: Image.asset(boardModel.imageUrl).image,
              fit: BoxFit.fill,
            ),
          ),
        ),
        (context.height * 0.11).ph,
        Text(
          boardModel.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: context.width * 0.04,
          ),
        ),
        (context.height * 0.05).ph,
        Text(
          boardModel.descreption,
        ),
      ],
    );
  }
}
