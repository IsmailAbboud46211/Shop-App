import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/app/global/custom_spinkit.dart';
import 'package:shop_app/app/global/custom_toast.dart';
import 'package:shop_app/app/global/initial_screen.dart';
import 'package:shop_app/app/src/connection/cubit/internet_connection_cubit.dart';
import 'package:shop_app/app/src/search_product/logic/cubit/search_cubit.dart';
import 'package:shop_app/app/src/search_product/view/widgets/search_list.dart';
import 'package:shop_app/app/global/custom_text_field.dart';
import 'package:shop_app/core/enum/toast_state.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';
import 'package:shop_app/core/shared/validation_function.dart';
import 'package:shop_app/core/themes/app_color.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
final TextEditingController _serachController = TextEditingController();

class _SearchProductScreenState extends State<SearchProductScreen> {
  @override
  void dispose() {
    _serachController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(
          top: context.width * 0.09,
          left: context.width * 0.09,
          right: context.width * 0.09,
        ),
        child: BlocProvider(
          create: (context) => SearchCubit(),
          child: BlocConsumer<SearchCubit, SearchStates>(
            listener: (context, state) {
              if (state is SearchFailed) {
                customToast(
                  message: state.message,
                  state: ToastState.ERROR,
                  width: context.width,
                );
              }
            },
            builder: (context, state) {
              final searchCubit = SearchCubit.get(context);
              var searchProducts = searchCubit.searchModel.data?.data ?? [];
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formkey,
                      child: CustomTextFormField(
                        controller: _serachController,
                        labekText: "Search",
                        hintText: "What do you search about? ",
                        validator: (value) => searchValidator(value),
                        textInputText: TextInputType.text,
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.deepBlue,
                        ),
                      ),
                    ),
                    (context.height * 0.025).ph,
                    Center(
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        onPressed: () {
                          if (_serachController.text.isNotEmpty) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            searchCubit.search(text: _serachController.text);
                          } else {
                            BlocListener<InternetConnectionCubit,
                                InternetConnectionState>(
                              listener: (context, state) {
                                if (state is InternetDisconnected) {
                                  customToast(
                                    message:
                                        "Internet disconnected , Please Check your connection",
                                    state: ToastState.ERROR,
                                    width: context.width,
                                  );
                                } else {
                                  customToast(
                                    message: "Please enter a vlaue",
                                    state: ToastState.ERROR,
                                    width: context.width,
                                  );
                                }
                              },
                            );
                          }
                        },
                        child: const Text(
                          "Search",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    ConditionalBuilder(
                      condition: state is! SearchProgress,
                      builder: (context) {
                        if (state is SearchInitial) {
                          return const InitialScreen(
                            iconData: FontAwesomeIcons.searchengin,
                            text: "What are you looking for ?",
                          );
                        }
                        return searchProducts.isNotEmpty
                            ? SearchProductsList(
                                searchProductsList: searchProducts,
                              )
                            : const InitialScreen(
                                iconData: FontAwesomeIcons.ghost,
                                text: "No products yet !",
                              );
                      },
                      fallback: (context) => const CustomSpinkit(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
