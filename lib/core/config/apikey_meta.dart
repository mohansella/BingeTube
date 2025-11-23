import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:timezone/timezone.dart' as tz;

enum ApiKeyStatus {
  notConfigured("Not Configured", Colors.grey),
  keyValid("Valid Key", Colors.green),
  keyInvalid("Invalid Key", Colors.red),
  limitedScope("Limited Scope", Colors.orange),
  quotaExceeded("Quota Exceeded", Colors.red);

  final String label;
  final Color color;

  const ApiKeyStatus(this.label, this.color);
}

enum ApiKeyQuotaType {
  validateKey,
  searchVideo,
  searchChannel,
  pullVideosInChannel,
}

class ApiKeyMeta {
  final ApiKeyStatus status;
  final String apiKey;
  final int configuredAtMillis;
  final int lastUsedAtMillis;
  final int lastQuotaResetMillis;

  //private since mutate from reference will cause error
  final Map<ApiKeyQuotaType, int> _quotaSections;

  Map<ApiKeyQuotaType, int> get quotaSections => {..._quotaSections};
  int get quotaUsed => _quotaSections.values.fold(0, (a, b) => a + b);

  static const int quotaLimit = 10000;

  const ApiKeyMeta({
    this.status = ApiKeyStatus.notConfigured,
    this.apiKey = '',
    this.configuredAtMillis = 0,
    this.lastUsedAtMillis = 0,
    this.lastQuotaResetMillis = 0,
    Map<ApiKeyQuotaType, int> quotaSections = const {},
  }) : _quotaSections = quotaSections;

  ApiKeyMeta copyWith({
    ApiKeyStatus? status,
    String? apiKey,
    int? configuredAtMillis,
    int? lastUsedAtMillis,
    int? lastQuotaResetMillis,
    Map<ApiKeyQuotaType, int>? quotaSections,
  }) {
    return ApiKeyMeta(
      status: status ?? this.status,
      apiKey: apiKey ?? this.apiKey,
      configuredAtMillis: configuredAtMillis ?? this.configuredAtMillis,
      lastUsedAtMillis: lastUsedAtMillis ?? this.lastUsedAtMillis,
      lastQuotaResetMillis: lastQuotaResetMillis ?? this.lastQuotaResetMillis,
      quotaSections: quotaSections ?? _quotaSections,
    );
  }

  factory ApiKeyMeta.fromJson(Map<String, dynamic> json) {
    final qsMap = json['quotaSections'] as Map<String, dynamic>? ?? {};
    return ApiKeyMeta(
      status: ApiKeyStatus.values.firstWhere(
        (e) => e.name == (json['status'] as String?),
        orElse: () => ApiKeyStatus.notConfigured,
      ),
      apiKey: json['apikey'] ?? '',
      configuredAtMillis: (json['configuredAtMillis'] as num?)?.toInt() ?? 0,
      lastUsedAtMillis: (json['lastUsedAtMillis'] as num?)?.toInt() ?? 0,
      lastQuotaResetMillis:
          (json['lastQuotaResetMillis'] as num?)?.toInt() ?? 0,
      quotaSections: {
        for (final qsEntry in qsMap.entries)
          if (ApiKeyQuotaType.values.any((e) => e.name == qsEntry.key))
            ApiKeyQuotaType.values.byName(qsEntry.key):
                (qsEntry.value as num?)?.toInt() ?? 0,
      },
    );
  }

  int get nextResetAtMillis => ApiKeyMeta.nextQuotaReset();

  Map<String, dynamic> toJson() {
    return {
      'status': status.name,
      'apikey': apiKey,
      'configuredAtMillis': configuredAtMillis,
      'lastUsedAtMillis': lastUsedAtMillis,
      'lastQuotaResetMillis': lastQuotaResetMillis,
      'quotaSections': _quotaSections.map((k, v) => MapEntry(k.name, v)),
    };
  }

  static ApiKeyMeta fromJsonString(String source) {
    return ApiKeyMeta.fromJson(jsonDecode(source));
  }

  static String toJsonString(ApiKeyMeta meta) {
    return jsonEncode(meta.toJson());
  }

  static int lastQuotaReset() {
    final pacific = tz.getLocation('America/Los_Angeles');
    final now = tz.TZDateTime.now(pacific);
    final lastReset = tz.TZDateTime(pacific, now.year, now.month, now.day);
    return lastReset.millisecondsSinceEpoch;
  }

  static int nextQuotaReset() {
    final pacific = tz.getLocation('America/Los_Angeles');
    final now = tz.TZDateTime.now(pacific);
    final nextReset = tz.TZDateTime(pacific, now.year, now.month, now.day + 1);
    return nextReset .millisecondsSinceEpoch;
  }
}
