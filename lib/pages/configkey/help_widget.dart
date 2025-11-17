import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfigKeyHelpWidget extends StatelessWidget {
  const ConfigKeyHelpWidget({super.key});

  final String _googleCloudConsoleUrl = 'https://console.cloud.google.com/';

  Future<void> _launchUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Guide: Obtaining Your YouTube API Key',
            style: text.titleLarge!.copyWith(
              color: color.primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          // Intro with link
          Text.rich(
            TextSpan(
              text: 'Follow these steps in the ',
              style: text.bodyMedium,
              children: [
                TextSpan(
                  text: 'Google Cloud Console',
                  style: text.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: color.primary,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _launchUrl(_googleCloudConsoleUrl),
                ),
                const TextSpan(
                  text: ' to generate and secure your API key:',
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Steps
          _buildStep(
            context,
            stepNumber: '1',
            title: 'Create or Select a Project',
            description:
                'Open the Google Cloud Console, sign in, and either select an existing project or create a new one.',
          ),

          const Divider(height: 28),

          _buildStep(
            context,
            stepNumber: '2',
            title: 'Enable the YouTube Data API',
            description:
                'In the API Library, search for "YouTube Data API v3" and click Enable to activate it for your project.',
          ),

          const Divider(height: 28),

          _buildStep(
            context,
            stepNumber: '3',
            title: 'Generate an API Key',
            description:
                'Go to APIs & Services → Credentials, click Create Credentials, and choose API Key. A key will be generated instantly.',
          ),

          const Divider(height: 28),

          _buildStep(
            context,
            stepNumber: '4',
            title: 'Restrict Your API Key (Recommended)',
            description:
                'Click Restrict Key and apply restrictions such as API restrictions or app restrictions to prevent misuse.',
          ),

          const SizedBox(height: 24),

          // Security warning
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.errorContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.security_rounded,
                  color: color.onErrorContainer,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: 'Security Warning: ',
                      style: text.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color.onErrorContainer,
                      ),
                      children: [
                        TextSpan(
                          text:
                              'Always restrict your API key to prevent unauthorized use. Never expose unrestricted keys in client apps.',
                          style: text.bodySmall!.copyWith(
                            fontWeight: FontWeight.normal,
                            color: color.onErrorContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Step UI Builder ---
  Widget _buildStep(
    BuildContext context, {
    required String stepNumber,
    required String title,
    required String description,
  }) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: color.primary,
          child: Text(
            stepNumber,
            style: text.labelMedium!.copyWith(
              color: color.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: text.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: text.bodyMedium!.copyWith(
                  color: color.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
