import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';

AwesomeDialog customAwesomeDialog({
  required BuildContext context,
  required String title,
  required String message,
  required var width,
  String btnOkText = "Ok",
  String btnCancelText = "Cancel",
  DialogType? type = DialogType.info,
  Function()? okAction,
  Function()? cancelAction,
  Color btnOkColor = Colors.green,
  Color btnCancelColor = Colors.red,
}) {
  return AwesomeDialog(
    alignment: Alignment.center,
    context: context,
    title: title,
    body: Padding(
      padding: EdgeInsets.all(width * 0.09),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    ),
    dialogType: type!,
    btnOkText: btnOkText,
    btnOkOnPress: okAction,
    btnCancelOnPress: cancelAction,
    animType: AnimType.scale,
    btnCancelText: btnCancelText,
    btnCancelColor: btnCancelColor,
    btnOkColor: btnOkColor,
  )..show();
}
