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
    ApiKeyUtil.adjustQuota(ref);
    return Column(
      children: [
        ListTile(
          title: const Text('Key Status'),
          subtitle: Text(
            meta.status.label,
            style: TextStyle(color: meta.status.color),
          ),
        ),
        _buildTimeList('Configured On', meta.configuredAtMillis),
        _buildTimeList('Last Used At', meta.lastUsedAtMillis),
        _buildTimeList('Last Quota Reset At', meta.lastQuotaResetMillis),
        _buildTimeList('Next Quota Reset At', meta.nextQuotaResetMillis),
        _buildQuotaUsed(meta),
      ],
    );
  }

  Widget _buildTimeList(String title, int epochMillis) {
    bool isInvalid = epochMillis <= 0;
    final date = DateTime.fromMillisecondsSinceEpoch(epochMillis);
    final isoStr = date.toIso8601String();
    return ListTile(
      title: Text(title),
      subtitle: isInvalid
          ? Text('-')
          : Timeago(
              date: date,
              allowFromNow: true,
              refreshRate: const Duration(seconds: 1),
              builder: (BuildContext context, String value) {
                return Text(value);
              },
            ),
      trailing: Text(
        isInvalid
            ? ''
            : isoStr.substring(0, isoStr.length - 4).replaceAll('T', ' '),
      ),
    );
  }

  Widget _buildQuotaUsed(ApiKeyMeta meta) {
    return ListTile(
      title: Text('Quota Used'),
      subtitle: Text('${meta.quotaUsed}'),
    );
  }
}
