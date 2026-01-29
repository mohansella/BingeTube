import 'package:drift/drift.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/tables/playlists.dart';
import 'package:bingetube/core/db/access/channels.dart';

part '../../../generated/core/db/access/playlists.g.dart';

class PlaylistModel {}

@DriftAccessor(
  tables: [
    Playlists,
    PlaylistSnippets,
    PlaylistThumbnails,
    PlaylistContentDetails,
  ],
)
class VideosDao extends DatabaseAccessor<Database> with _$VideosDaoMixin {
  late ChannelsDao _channelsDao;
  VideosDao(super.attachedDatabase) {
    _channelsDao = ChannelsDao(attachedDatabase);
  }

}
