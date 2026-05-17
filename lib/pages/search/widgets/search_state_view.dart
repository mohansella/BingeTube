import 'package:flutter/material.dart';

class SearchStateView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final bool isLoading;

  const SearchStateView({
    required this.icon,
    required this.title,
    required this.message,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 24, 32, 80),
        child: Column(
          mainAxisSize: .min,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    )
                  : Icon(icon, size: 30, color: theme.colorScheme.onSecondaryContainer),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: .center,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Text(
                message,
                textAlign: .center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
