import 'package:drift/drift.dart';
import 'package:bingetube/core/db/tables/mixins.dart';

@TableIndex(name: 'ChannelsIndexETag', columns: {#etag})
class Channels extends Table with TableTimedMixin {
  late final id = text()();
  late final etag = text().nullable()();
  late final setag = text().nullable()();

  @override
  get primaryKey => {id};
}

class ChannelSnippets extends Table {
  late final id = text().references(Channels, #id)();
  late final title = text()();
  late final description = text()();

  @override
  get primaryKey => {id};
}

class ChannelThumbnails extends Table {
  late final id = text().references(Channels, #id)();
  late final defaultUrl = text()();
  late final mediumUrl = text()();
  late final highUrl = text()();

  @override
  get primaryKey => {id};
}

class ChannelContentDetails extends Table {
  late final id = text().references(Channels, #id)();
  late final likesPlaylist = text().nullable()();
  late final uploadPlaylist = text().nullable()();

  @override
  get primaryKey => {id};
}

class ChannelStatistics extends Table {
  late final id = text().references(Channels, #id)();
  late final viewCount = integer()();
  late final subscriberCount = integer()();
  late final hiddenSubscriberCount = boolean()();
  late final videoCount = integer()();

  @override
  get primaryKey => {id};
}

class ChannelStatuses extends Table {
  late final id = text().references(Channels, #id)();
  late final privacyStatus = text()();
  late final isLinked = boolean()();
  late final longUploadsStatus = text()();
  late final madeForKids = boolean().nullable()();

  @override
  get primaryKey => {id};
}
