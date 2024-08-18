import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/app/global/custom_toast.dart';
import 'package:shop_app/app/global/initial_screen.dart';
import 'package:shop_app/app/src/categories/logic/cubit/categories_cubit.dart';
import 'package:shop_app/app/src/categories/view/widgets/categories_custom_painter.dart';
import 'package:shop_app/app/src/categories/view/widgets/categories_screen_cond_builder.dart';
import 'package:shop_app/app/src/connection/cubit/internet_connection_cubit.dart';
import 'package:shop_app/core/enum/toast_state.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/themes/app_color.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final categoriesCubit = CategoriesCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : AppColors.deepBlue,
          ),
        ),
      ),
      body: BlocBuilder<CategoriesCubit, CategoriesStates>(
        builder: (context, state) {
          return BlocConsumer<InternetConnectionCubit, InternetConnectionState>(
            listener: (context, state) {
              if (state is InternetConnected) {
                customToast(
                  message: "Back to connection",
                  state: ToastState.SUCCESS,
                  width: context.width,
                );
              } else if (state is InternetDisconnected) {
                customToast(
                  message: "Internet disconnected ",
                  state: ToastState.ERROR,
                  width: context.width,
                );
              }
            },
            builder: (context, state) {
              if (state is InternetDisconnected) {
                return const InitialScreen(
                  iconData: FontAwesomeIcons.wifi,
                  text: "Internet disconnected please check it",
                );
              }
              return Stack(children: [
                Positioned.fill(
                  child: CustomPaint(
                    size: Size(context.width, (context.width * 2.5).toDouble()),
                    painter: RPSCustomPainter(),
                  ),
                ),
                Positioned.fill(
                  child: BuildCategoriesConditionalBuilder(
                    categoriesList: categoriesCubit
                        .categoriesModel.categoriesDataModel.data,
                  ),
                ),
              ]);
            },
          );
        },
      ),
    );
  }
}
