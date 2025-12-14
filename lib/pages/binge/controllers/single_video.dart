import 'package:bingetube/pages/binge/controllers/base_controller.dart';

class SingleVideoBingeController implements BaseBingeController {
  final String videoId;

  SingleVideoBingeController(this.videoId);

  @override
  String get pageTitle => 'Binge Video';

}
