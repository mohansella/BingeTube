import 'package:bingetube/core/db/tables/channels.dart';
import 'package:bingetube/core/db/tables/mixins.dart';
import 'package:bingetube/core/db/tables/videos.dart';
import 'package:drift/drift.dart';

@TableIndex(name: 'ChannelSearchesIndexQuery', columns: {#query})
class ChannelSearches extends Table with TableTimedMixin {
  late final id = integer().autoIncrement()();
  late final query = text()();
}

class ChannelSearchVsChannels extends Table {
  late final searchId = integer().references(ChannelSearches, #id)();
  late final channelId = text().references(Channels, #id)();
  late final priority = integer()();

  @override
  get primaryKey => {searchId, channelId};
}

@TableIndex(name: 'VideoSearchesIndexQuery', columns: {#query})
class VideoSearches extends Table with TableTimedMixin {
  late final id = integer().autoIncrement()();
  late final query = text()();
}

class VideoSearchVsVideos extends Table {
  late final searchId = integer().references(VideoSearches, #id)();
  late final videoId = text().references(Videos, #id)();
  late final priority = integer()();

  @override
  get primaryKey => {searchId, videoId};
}
