import 'package:bingetube/core/config/apikey_meta.dart';
import 'package:flutter/material.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

class ApiKeyQuotaWidget extends StatelessWidget {
  final ApiKeyMeta meta;

  const ApiKeyQuotaWidget({super.key, required this.meta});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Key Status'),
          subtitle: Text(
            meta.status.name,
            style: TextStyle(color: meta.status.color),
          ),
        ),
        _buildTimeList('Configured On', meta.configuredAtMillis),
        _buildTimeList('Last Used At', meta.lastUsedAtMillis),
        _buildTimeList('Last Quota Reset At', meta.lastQuotaResetMillis),
        _buildTimeList('Next Quota Reset At', meta.nextResetAtMillis),
      ],
    );
  }

  ListTile _buildTimeList(String title, int epochMillis) {
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
}
