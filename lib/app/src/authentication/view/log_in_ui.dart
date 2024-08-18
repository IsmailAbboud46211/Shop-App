import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shop_app/app/src/authentication/logic/cubit/login_cubit.dart';
import 'package:shop_app/app/global/custom_awesom_dialog.dart';
import 'package:shop_app/app/global/custom_text_field.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';
import 'package:shop_app/core/extension/routing_extenstion.dart';
import 'package:shop_app/core/router/route_name.dart';
import 'package:shop_app/core/shared/validation_function.dart';
import 'package:shop_app/core/themes/app_color.dart';
import 'package:shop_app/core/utils/images.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
final TextEditingController _email = TextEditingController();
final TextEditingController _password = TextEditingController();

_submitForm({
  required BuildContext context,
  required LogInCubit cubit,
}) {
  if (_formkey.currentState!.validate()) {
    cubit.login(email: _email.text, password: _password.text);
  }
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  void dispose() {
    _email.clear();
    _password.clear();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage(Images.authScreenBackground), context);
    final LogInCubit cubit = LogInCubit.get(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.authScreenBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(context.width * 0.09),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (context.height * 0.05).ph,
                    Text(
                      "Welcome :)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width / 15,
                        color: AppColors.deepBlue,
                      ),
                    ),
                    (context.height * 0.005).ph,
                    Text(
                      "Log in now to see all new product",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBlue,
                      ),
                    ),
                    (context.height * 0.05).ph,
                    CustomTextFormField(
                      controller: _email,
                      labekText: "E-mail",
                      hintText: "Please enter a correct E-mail",
                      validator: emailValidator,
                      errorMessageColor: AppColors.softGrey,
                      textInputText: TextInputType.emailAddress,
                      prefixIcon: Icon(
                        Icons.email,
                        color: AppColors.deepBlue,
                      ),
                      borderSideColor: AppColors.softGrey,
                    ),
                    (context.height * 0.025).ph,
                    CustomTextFormField(
                      controller: _password,
                      labekText: "Passwprd",
                      hintText: "Please enter a  valid password",
                      validator: (value) => passwordValidator(
                        value,
                        message: "Enter password please",
                      ),
                      textInputText: TextInputType.visiblePassword,
                      prefixIcon: Icon(
                        Icons.password,
                        color: AppColors.deepBlue,
                      ),
                      errorMessageColor: AppColors.softGrey,
                      isPasswordTextField: true,
                      borderSideColor: AppColors.softGrey,
                    ),
                    (context.height * 0.025).ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account ? ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.deepBlue,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.go(
                            routeName: RoutesNames.register,
                            replacement: true,
                          ),
                          child: const Text(
                            "Register now",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    (context.height * 0.025).ph,
                    BlocConsumer<LogInCubit, LogInStates>(
                      builder: (context, state) => ConditionalBuilder(
                        condition: state is! LogInProgress,
                        builder: (context) => ElevatedButton(
                            onPressed: () => _submitForm(
                                  context: context,
                                  cubit: cubit,
                                ),
                            child:const Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        fallback: (context) => Center(
                          child: SpinKitFadingCircle(
                            color: AppColors.softGrey,
                            size: context.width * 0.15,
                          ),
                        ),
                      ),
                      listener: (context, state) {
                        if (state is LogInSucceeded) {
                          customAwesomeDialog(
                            context: context,
                            title: "Scucceeded",
                            message: state.message,
                            width: context.width,
                            type: DialogType.success,
                            okAction: () => context.go(
                              routeName: RoutesNames.home,
                              replacement: true,
                            ),
                          );
                        } else if (state is LogInFailed) {
                          customAwesomeDialog(
                            context: context,
                            title: "Failed",
                            message: state.message,
                            width: context.width,
                            type: DialogType.error,
                            btnOkText: "Ok",
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
