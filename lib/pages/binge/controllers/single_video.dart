import 'package:bingetube/pages/binge/controllers/base_controller.dart';

class SingleVideoBingeController extends BaseBingeController {
  final String videoId;

  SingleVideoBingeController(this.videoId);

  @override
  String get pageTitle => 'Binge Video';

  @override
  String get activeVideoId => videoId;

  @override
  bool get isNextVideoExists => false;

  @override
  bool get isPrevVideoExists => false;
}
