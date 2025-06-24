import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showError(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red[400],
      textColor: Colors.white,
      fontSize: 16.0);
}

showSnak(
    BuildContext context, String message, String message2, VoidCallback ontap) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text.rich(TextSpan(text: message + '\n', children: [
          TextSpan(
              text: message2,
              style: TextStyle(decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()..onTap = ontap)
        ])),
      ),
      backgroundColor: Colors.red[400],
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      duration: const Duration(seconds: 4),
    ),
  );
}
