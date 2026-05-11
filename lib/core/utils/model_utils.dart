sealed class ModelUtils {
  static String selectImageUrl(List<String?> urls) {
    return urls.whereType<String>().where((s) => s.isNotEmpty).firstOrNull ?? '';
  }
}
