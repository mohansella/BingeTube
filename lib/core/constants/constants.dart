sealed class PageSizeConstants {
  static final channelEntriesInSearchPage = 50;
}

sealed class CacheConstants {
  static final syncChannelAfter = Duration(hours: 1);
  static final syncVideosAfter = Duration(hours: 1);
  static final syncChannelSearchResultAfter = Duration(hours: 1);
  static final syncVideosSearchResultAfter = Duration(hours: 1);
}
