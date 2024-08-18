import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shop_app/app/src/authentication/logic/cubit/register_cubit.dart';
import 'package:shop_app/app/global/custom_awesom_dialog.dart';
import 'package:shop_app/app/global/custom_text_field.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';
import 'package:shop_app/core/extension/routing_extenstion.dart';
import 'package:shop_app/core/router/route_name.dart';
import 'package:shop_app/core/shared/validation_function.dart';
import 'package:shop_app/core/themes/app_color.dart';
import 'package:shop_app/core/utils/images.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
final TextEditingController _email = TextEditingController();
final TextEditingController _password = TextEditingController();
final TextEditingController _userName = TextEditingController();
final TextEditingController _phoneNumber = TextEditingController();

void _submitForm({
  required BuildContext context,
  required RegisterCubit cubit,
}) {
  if (_formkey.currentState!.validate()) {
    cubit.register(
      email: _email.text,
      password: _password.text,
      name: _userName.text,
      phone: _phoneNumber.text,
    );
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void dispose() {
    _email.clear();
    _password.clear();
    _userName.clear();
    _phoneNumber.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage(Images.authScreenBackground), context);
    final RegisterCubit cubit = RegisterCubit.get(context);

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
                    Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width / 15,
                        color: AppColors.deepBlue,
                      ),
                    ),
                    (context.height * 0.025).ph,
                    Text(
                      "Welcome to our app",
                      style: TextStyle(
                        color: AppColors.deepBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    (context.height * 0.025).ph,
                    CustomTextFormField(
                      controller: _email,
                      labekText: "E-mail",
                      hintText: "Please enter a correct E-mail",
                      validator: emailValidator,
                      textInputText: TextInputType.emailAddress,
                      prefixIcon: Icon(
                        Icons.email,
                        color: AppColors.deepBlue,
                      ),
                      borderSideColor: AppColors.softGrey,
                    ),
                    (context.height * 0.025).ph,
                    CustomTextFormField(
                      controller: _userName,
                      labekText: "User Name",
                      hintText: "Please enter your name ",
                      validator: (value) => nameValidator(value,
                          message: "Please enter your name"),
                      textInputText: TextInputType.name,
                      prefixIcon: Icon(
                        Icons.person,
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
                      isPasswordTextField: true,
                      borderSideColor: AppColors.softGrey,
                    ),
                    (context.height * 0.025).ph,
                    CustomTextFormField(
                      controller: _phoneNumber,
                      labekText: "Phone Number",
                      hintText: "Please enter your phone number start with 09",
                      validator: phoneNumberValidator,
                      textInputText: TextInputType.phone,
                      prefixIcon: Icon(
                        Icons.phone,
                        color: AppColors.deepBlue,
                      ),
                      isPasswordTextField: false,
                      isPhoneNumberTextField: true,
                      maxLength: 10,
                      borderSideColor: AppColors.softGrey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an accout ? ",
                          style: TextStyle(
                            color: AppColors.deepBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.go(
                            routeName: RoutesNames.login,
                            replacement: true,
                          ),
                          child: Text(
                            "Login now",
                            style: TextStyle(
                              color: AppColors.softGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    (context.height * 0.0025).ph,
                    BlocConsumer<RegisterCubit, RegisterStates>(
                      builder: (context, state) => ConditionalBuilder(
                        condition: state is! RegisterProgress,
                        builder: (context) => ElevatedButton(
                            onPressed: () => _submitForm(
                                  context: context,
                                  cubit: cubit,
                                ),
                            child: const Text(
                              "Register",
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
                        if (state is RegisterSucceeded) {
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
                        } else if (state is RegisterFailed) {
                          customAwesomeDialog(
                            context: context,
                            title: "Failed",
                            message: state.message,
                            width: context.width,
                            type: DialogType.error,
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
