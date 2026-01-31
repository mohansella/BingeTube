sealed class PageSizeConstants {
  static final channelEntriesInSearchPage = 50;
  static final videoEntriesInSearchPage = 50;
}

sealed class CacheConstants {
  static final syncChannelAfter = Duration(hours: 1);
  static final syncVideosAfter = Duration(hours: 1);
  static final syncChannelSearchResultAfter = Duration(hours: 1);
  static final syncVideosSearchResultAfter = Duration(hours: 1);
  static final syncChannelPlaylistAfter = Duration(hours: 1);
  static final syncPlaylistMetaAfter = Duration(hours: 1);
}
