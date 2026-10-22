import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSupport {
  static const email = 'mohansella.store@gmail.com';

  static Future<void> openEmail(BuildContext context) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'BingeTube feedback',
        'body': 'Hi,\n\nI’d like to report a problem or suggest a feature:\n\n\n\n',
      },
    );

    try {
      if (await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        return;
      }
    } catch (_) {
      // Show the address below when no email app can handle the link.
    }

    if (!context.mounted) return;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Contact BingeTube'),
        content: const SelectableText(
          'No email app is available. You can email us at:\n$email',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
          TextButton.icon(
            onPressed: () async {
              await Clipboard.setData(const ClipboardData(text: email));
              if (dialogContext.mounted) Navigator.pop(dialogContext);
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Email address copied')));
              }
            },
            icon: const Icon(Icons.copy),
            label: const Text('Copy email'),
          ),
        ],
      ),
    );
  }
}
