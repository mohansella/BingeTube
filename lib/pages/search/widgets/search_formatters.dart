String formatCompactCount(int value) {
  if (value < 1000) {
    return value.toString();
  }

  if (value >= 1000000000) {
    return '${_formatCompactValue(value / 1000000000)}B';
  }
  if (value >= 1000000) {
    return '${_formatCompactValue(value / 1000000)}M';
  }
  return '${_formatCompactValue(value / 1000)}K';
}

String _formatCompactValue(double value) {
  final formatted = value >= 10 ? value.toStringAsFixed(0) : value.toStringAsFixed(1);
  return formatted.replaceFirst(RegExp(r'\.0$'), '');
}
