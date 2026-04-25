import 'package:bingetube/core/config/apikey_meta.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

sealed class ApiKeyUtil {
  static final Logger _logger = LogManager.getLogger('ApiKeyUtil');

  static String readApiKey(WidgetRef ref) {
    return ref.read(ConfigProviders.apiKeyMeta).apiKey;
  }

  static void updateApiKeyStatus(WidgetRef ref, ApiKeyStatus status) {
    final meta = ref.read(ConfigProviders.apiKeyMeta);
    if (meta.status == status) return;
    ref.read(ConfigProviders.apiKeyMeta.notifier).save(meta.copyWith(status: status));
  }

  static void adjustQuota(WidgetRef ref) {
    final meta = ref.read(ConfigProviders.apiKeyMeta);
    if (meta.isQuotaUsedInvalid) {
      Future(() {
        _logger.info(
          'resetting quota - existing: ${meta.nextQuotaResetMillis} calculated:${ApiKeyMeta.nextQuotaReset()}',
        );
        final newMeta = meta.resetQuota();
        ref.read(ConfigProviders.apiKeyMeta.notifier).save(newMeta);
      });
    }
  }

  static void addQuota(WidgetRef ref, ApiKeyQuotaType quotaType, int count) {
    adjustQuota(ref);
    final meta = ref.read(ConfigProviders.apiKeyMeta);
    final quotaSections = meta.quotaSections;
    quotaSections[quotaType] = count + (quotaSections[quotaType] ?? 0);
    _logger.info('adding $quotaType with $count causing $quotaSections');
    final newMeta = meta.copyWith(
      lastUsedAtMillis: DateTime.now().millisecondsSinceEpoch,
      quotaSections: quotaSections,
    );
    ref.read(ConfigProviders.apiKeyMeta.notifier).save(newMeta);
  }
}
