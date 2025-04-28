import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppConstants {

  static void showErrorDialog(
      {required BuildContext context, required String msg}) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(
                msg,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  child: const Text("Ok"),
                ),
              ],
            ));
  }

  static BoxDecoration authButtonDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(
        10,
      ),
      gradient: const LinearGradient(colors: [
        Color.fromRGBO(
          143,
          148,
          251,
          1,
        ),
        Color.fromRGBO(
          143,
          148,
          251,
          .6,
        ),
      ]));
}
