import 'package:bingetube/core/db/access/playlists.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/models/binge_model.dart';
import 'package:bingetube/pages/binge/controllers/base_controller.dart';

class PlaylistBingeController extends BaseBingeController {
  final String playlistId;
  PlaylistBingeController(
    this.playlistId,
    String videoId, {
    required super.initialHeroId,
    required super.initialHeroImg,
  }) {
    super.videoId = videoId;
  }

  @override
  Stream<BingeModel> get dbStream {
    return PlaylistsDao(Database()).getBingeModel(playlistId).asStream();
  }
}
