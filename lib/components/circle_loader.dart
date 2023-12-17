import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class CircleLoader {
  static final CircleLoader _instance = CircleLoader.internal();

  CircleLoader.internal();

  factory CircleLoader() => _instance;

  static void showCustomDialog(
    BuildContext context, {
    Color color = const Color(0xFFFFFFFF),
  }) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            shadowColor:Colors.transparent,
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Platform.isAndroid
                    ? CircularProgressIndicator(
                        color: color,
                      )
                    : CupertinoActivityIndicator(
                        color: color,
                        radius: 20,
                        animating: true,
                      ),
              ],
            ),
          );
        });
  }

  static void hideLoader(context) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }


  static void iosLoaderShow(){
    const CupertinoActivityIndicator(radius: 20.0, animating: false);
  }
}
