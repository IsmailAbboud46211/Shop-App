import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shop_app/app/src/authentication/data/model/user_model.dart';
import 'package:shop_app/app/src/profile/logic/cubit/profile_cubit.dart';
import 'package:shop_app/app/src/update_profile/logic/cubit/update_profile_cubit.dart';
import 'package:shop_app/app/src/update_profile/view/widgets/profile_image.dart';
import 'package:shop_app/app/global/custom_text_field.dart';
import 'package:shop_app/app/global/custom_toast.dart';
import 'package:shop_app/core/database/boxes_names.dart';
import 'package:shop_app/core/database/keys_names.dart';
import 'package:shop_app/core/enum/boxes_type.dart';
import 'package:shop_app/core/enum/toast_state.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';
import 'package:shop_app/core/shared/validation_function.dart';
import 'package:shop_app/core/themes/app_color.dart';
import 'package:shop_app/main.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();
TextEditingController _userName = TextEditingController();
TextEditingController _phoneNumber = TextEditingController();

void _submitForm({
  required BuildContext context,
  required UpdateProfileCubit cubit,
}) {
  if (_password.text.isEmpty) {
    customToast(
      message:
          "For security purposes, Please enter your password before updating your information.",
      state: ToastState.WORNING,
      width: context.width,
    );
  }
  if (_formkey.currentState!.validate()) {
    cubit.updateProfile(
      email: _email.text,
      password: _password.text,
      name: _userName.text,
      phone: _phoneNumber.text,
    );
  }
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  void dispose() {
    _email.clear();
    _password.clear();
    _userName.clear();
    _phoneNumber.clear();
    super.dispose();
  }

  @override
  void initState() {
    UserModel userModel = hiveDB.getData(
      boxName: BoxesNames.userModel,
      key: KeysNames.user,
      boxType: BoxType.USERMODEL,
      defaultValue: UserModel(
        id: 0,
        email: "",
        token: "",
        phoneNumber: "",
        userName: "",
        image: "",
        points: 0,
        credit: 0,
      ),
    );

    _userName.text = userModel.userName;
    _email.text = userModel.email;
    _phoneNumber.text = userModel.phoneNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileCubit = ProfileCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileImage(
              imageUrl: profileCubit.userModel.image,
            ),
            Padding(
              padding: EdgeInsets.all(context.width * 0.09),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (context.height * 0.035).ph,
                    CustomTextFormField(
                      controller: _email,
                      labekText: "E-mail",
                      hintText: "Please enter a correct E-mail",
                      validator: emailValidator,
                      textInputText: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email),
                    ),
                    (context.height * 0.025).ph,
                    CustomTextFormField(
                      controller: _userName,
                      labekText: "User Name",
                      hintText: "Please enter your name ",
                      validator: (value) => nameValidator(
                        value,
                        message: "Please enter your name",
                      ),
                      textInputText: TextInputType.name,
                      prefixIcon: const Icon(Icons.person),
                    ),
                    (context.height * 0.025).ph,
                    CustomTextFormField(
                      controller: _password,
                      labekText: "Passwprd",
                      hintText: "Please enter a  valid password",
                      validator: (value) => passwordValidator(
                        value,
                        message: "Enter password befor update",
                      ),
                      textInputText: TextInputType.visiblePassword,
                      prefixIcon: const Icon(Icons.password),
                      isPasswordTextField: true,
                    ),
                    (context.height * 0.025).ph,
                    CustomTextFormField(
                      controller: _phoneNumber,
                      labekText: "Phone Number",
                      hintText: "Please enter your phone number start with 09",
                      validator: phoneNumberValidator,
                      textInputText: TextInputType.phone,
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    (context.height * 0.025).ph,
                    BlocProvider<UpdateProfileCubit>(
                      create: (context) => UpdateProfileCubit(),
                      child:
                          BlocConsumer<UpdateProfileCubit, UpdateProfileStates>(
                        builder: (context, state) => ConditionalBuilder(
                          condition: state is! UpdateProfileProgress,
                          builder: (context) => ElevatedButton(
                            onPressed: () => _submitForm(
                              context: context,
                              cubit: UpdateProfileCubit.get(context),
                            ),
                            child: const Text("Update"),
                          ),
                          fallback: (context) => Center(
                            child: SpinKitFadingCircle(
                              color: AppColors.lightGrey,
                              size: context.width * 0.12,
                            ),
                          ),
                        ),
                        listener: (context, state) {
                          if (state is UpdateProfileSucceeded) {
                            profileCubit.getPtofile();
                            customToast(
                              message: state.message,
                              state: ToastState.SUCCESS,
                              width: context.width,
                            );
                          } else if (state is UpdateProfileFailed) {
                            customToast(
                              message: state.message,
                              state: ToastState.ERROR,
                              width: context.width,
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
