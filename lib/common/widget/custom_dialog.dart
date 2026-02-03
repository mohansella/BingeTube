import 'package:flutter/material.dart';

class CustomDialog {
  static Future<bool> show(
    BuildContext context,
    String title,
    String confirmText,
    Widget? content, {
    String? cancelText,
    bool barrierDismissible = false,
  }) async {
    var toReturn = false;
    await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            if (cancelText != null) ...[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(cancelText),
              ),
            ],
            TextButton(
              onPressed: () {
                toReturn = true;
                Navigator.pop(context);
              },
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
    return toReturn;
  }
}
