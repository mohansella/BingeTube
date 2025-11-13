import 'package:flutter/material.dart';

class CustomDialog {
  
  static Future<dynamic> show(
    BuildContext context,
    String title,
    String buttonTxt,
    Widget? content,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(buttonTxt),
            ),
          ],
        );
      },
    );
  }
}
