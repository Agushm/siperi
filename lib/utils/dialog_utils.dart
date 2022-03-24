// ignore_for_file: prefer_const_constructors

import 'package:animations/animations.dart';
import 'package:aplikasi_siperi/ui/constants/theme.dart';
import 'package:flutter/material.dart';

import '../core/models/models.dart';
import '../ui/widgets/widgets.dart';

class DialogUtils {
  static DialogUtils instance = DialogUtils();

  void showInfo(BuildContext context,
      {String? title,
      String? message,
      Function()? onPressed,
      String? btnText}) {
    showModal(
        context: context,
        configuration:
            FadeScaleTransitionConfiguration(barrierDismissible: false),
        builder: (context) {
          return InfoDialog(
            title: title,
            message: message,
            onPressed: onPressed,
            btnText: btnText,
          );
        });
  }

  Future<bool?> showConfirmDialog(
      BuildContext context, String title, String message,
      {String? btnCancel, String? btnOK}) {
    return showModal(
        context: context,
        configuration:
            FadeScaleTransitionConfiguration(barrierDismissible: false),
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              MaterialButton(
                child: Text(
                  btnCancel != null ? btnCancel : 'Tidak',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              MaterialButton(
                color: Constants.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(btnOK != null ? btnOK : 'Ya',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        });
  }
}
