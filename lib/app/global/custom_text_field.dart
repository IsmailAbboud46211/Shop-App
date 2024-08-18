import 'package:flutter/material.dart';
import 'package:shop_app/core/themes/app_color.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labekText;
  final Color errorMessageColor;
  final Color? borderSideColor;
  final String hintText;
  final Icon prefixIcon;
  final bool isPasswordTextField;
  final TextInputType textInputText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final int? maxLength;
  final bool isPhoneNumberTextField;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labekText,
    this.isPasswordTextField = false,
    this.isPhoneNumberTextField = false,
    this.initialValue,
    this.maxLength = 9999999999,
    this.errorMessageColor=Colors.redAccent,
    this.borderSideColor,
    required this.hintText,
    required this.textInputText,
    required this.prefixIcon,
    required this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

bool isPasswordVisible = false;

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return TextFormField(
      controller: widget.controller,
      maxLength: widget.isPhoneNumberTextField ? widget.maxLength : null,
      initialValue: widget.initialValue,
      obscuringCharacter: '*',
      keyboardType: widget.textInputText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText:
          widget.isPasswordTextField == true ? !isPasswordVisible : false,
      cursorColor: AppColors.deepBlue,
      decoration: InputDecoration(
        hoverColor: AppColors.deepBlue,
        errorStyle:  TextStyle(
          color:widget.errorMessageColor,
          fontWeight: FontWeight.bold,
        ),
        labelStyle: TextStyle(color: AppColors.deepBlue),
        helperStyle: TextStyle(color: AppColors.primaryColor),
      //  hintStyle: TextStyle(color: AppColors.primaryColor),
        prefixIconColor: AppColors.primaryColor,
        focusColor: AppColors.primaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderSideColor?? AppColors.primaryColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(width * 0.5),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(width * 0.5),
          ),
        ),
        labelText: widget.labekText,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPasswordTextField == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                icon: isPasswordVisible == true
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              )
            : const SizedBox(),
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}
