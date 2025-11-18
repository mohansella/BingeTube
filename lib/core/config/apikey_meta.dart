import 'dart:convert';

enum ApiKeyStatus {
  notConfigured,
  keyValid,
  keyInvalid,
  limitedScope,
  quotaExceeded,
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
  final int lastUsedAtMillis;
  final int configuredAtMillis;

  //private since mutate from reference will cause error
  final Map<ApiKeyQuotaType, int> _quotaSections;

  int get quotaUsed => _quotaSections.values.fold(0, (a, b) => a + b);

  static const int quotaLimit = 10000;

  const ApiKeyMeta({
    this.status = ApiKeyStatus.notConfigured,
    this.apiKey = '',
    this.lastUsedAtMillis = 0,
    this.configuredAtMillis = 0,
    Map<ApiKeyQuotaType, int> quotaSections = const {},
  }) : _quotaSections = quotaSections;

  ApiKeyMeta copyWith({
    ApiKeyStatus? status,
    String? apiKey,
    int? lastUsedAtMillis,
    int? configuredAtMillis,
    Map<ApiKeyQuotaType, int>? quotaSections,
  }) {
    return ApiKeyMeta(
      status: status ?? this.status,
      apiKey: apiKey ?? this.apiKey,
      lastUsedAtMillis: lastUsedAtMillis ?? this.lastUsedAtMillis,
      configuredAtMillis: configuredAtMillis ?? this.configuredAtMillis,
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
      lastUsedAtMillis: (json['lastUsedAtMillis'] as num?)?.toInt() ?? 0,
      configuredAtMillis: (json['configuredAtMillis'] as num?)?.toInt() ?? 0,
      quotaSections: {
        for (final qsEntry in qsMap.entries)
          if (ApiKeyQuotaType.values.any((e) => e.name == qsEntry.key))
            ApiKeyQuotaType.values.byName(qsEntry.key):
                (qsEntry.value as num?)?.toInt() ?? 0,
      },
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status.name,
      'apikey': apiKey,
      'lastUsedAtMillis': lastUsedAtMillis,
      'configuredAtMillis': configuredAtMillis,
      'quotaSections': _quotaSections.map((k, v) => MapEntry(k.name, v)),
    };
  }

  static ApiKeyMeta fromJsonString(String source) {
    return ApiKeyMeta.fromJson(jsonDecode(source));
  }

  static String toJsonString(ApiKeyMeta meta) {
    return jsonEncode(meta.toJson());
  }
}
