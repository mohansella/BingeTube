import 'package:bingetube/core/config/apikey_meta.dart';
import 'package:bingetube/core/config/apikey_util.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

class ApiKeyQuotaWidget extends ConsumerWidget {
  const ApiKeyQuotaWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meta = ref.watch(ConfigProviders.apiKeyMeta);
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    ApiKeyUtil.adjustQuota(ref);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: color.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.speed_outlined, color: color.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Usage and quota',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              _StatusBadge(label: meta.status.label, color: meta.status.color),
            ],
          ),
          const SizedBox(height: 16),
          _buildQuotaUsed(context, meta),
          const Divider(height: 28),
          _buildTimeRow(context, 'Configured', meta.configuredAtMillis),
          _buildTimeRow(context, 'Last used', meta.lastUsedAtMillis),
          _buildTimeRow(context, 'Last quota reset', meta.lastQuotaResetMillis),
          _buildTimeRow(context, 'Next quota reset', meta.nextQuotaResetMillis),
        ],
      ),
    );
  }

  Widget _buildTimeRow(BuildContext context, String title, int epochMillis) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    bool isInvalid = epochMillis <= 0;
    final date = DateTime.fromMillisecondsSinceEpoch(epochMillis);
    final isoStr = date.toIso8601String();
    final timestamp = isInvalid
        ? ''
        : isoStr.substring(0, isoStr.length - 4).replaceAll('T', ' ');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 2),
                isInvalid
                    ? Text(
                        '-',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: color.onSurfaceVariant,
                        ),
                      )
                    : Timeago(
                        date: date,
                        allowFromNow: true,
                        refreshRate: const Duration(seconds: 1),
                        builder: (BuildContext context, String value) {
                          return Text(
                            value,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: color.onSurfaceVariant,
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
          if (!isInvalid) ...[
            const SizedBox(width: 16),
            Text(
              timestamp,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodySmall?.copyWith(color: color.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuotaUsed(BuildContext context, ApiKeyMeta meta) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final quotaRatio = (meta.quotaUsed / ApiKeyMeta.quotaLimit).clamp(0, 1).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Daily YouTube quota',
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              '${meta.quotaUsed}/${ApiKeyMeta.quotaLimit}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: color.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: quotaRatio,
            minHeight: 8,
            backgroundColor: color.surfaceContainerHighest,
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: color.withValues(alpha: 0.12),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}
