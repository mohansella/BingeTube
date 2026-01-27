import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum _Params { channelId, heroId, heroImg }

class ChannelPage extends ConsumerStatefulWidget {
  final Map<String, String> queryParameters;

  const ChannelPage(this.queryParameters, {super.key});

  static Map<String, String> buildParams({
    required String channelId,
    required String heroId,
    required String heroImg,
  }) {
    return <_Params, String>{
      .channelId: channelId,
      .heroId: heroId,
      .heroImg: heroImg,
    }.map((k, v) => MapEntry(k.name, v));
  }

  @override
  ConsumerState<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends ConsumerState<ChannelPage> {
  late String channelId;
  late String heroId;
  late String heroImg;

  @override
  void initState() {
    super.initState();
    final params = widget.queryParameters;
    channelId = params[_Params.channelId.name]!;
    heroId = params[_Params.heroId.name]!;
    heroImg = params[_Params.heroImg.name]!;
  }

  @override
  Widget build(BuildContext context) {
    return Text(channelId);
  }
}
