import 'package:bingetube/core/config/apikey_meta.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

sealed class CoreUtils {
  static String readApiKey(WidgetRef ref) {
    return ref.read(ConfigProviders.apiKeyMeta).apiKey;
  }

  static ApiKeyMeta readApiKeyMeta(WidgetRef ref) {
    return ref.read(ConfigProviders.apiKeyMeta);
  }

  static void writeApiKeyMeta(WidgetRef ref, ApiKeyMeta meta) {
    ref.read(ConfigProviders.apiKeyMeta.notifier).save(meta);
  }
}
