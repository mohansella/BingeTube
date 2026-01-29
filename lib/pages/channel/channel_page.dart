import 'package:bingetube/app/theme.dart';
import 'package:bingetube/core/db/access/channels.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:flutter/material.dart';
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
  final channelDao = ChannelsDao(Database());

  late String channelId;
  late String heroId;
  late String heroImg;

  bool isModelLoading = true;
  late ChannelModel model;

  @override
  void initState() {
    super.initState();
    final params = widget.queryParameters;
    channelId = params[_Params.channelId.name]!;
    heroId = params[_Params.heroId.name]!;
    heroImg = params[_Params.heroImg.name]!;

    channelDao.getChannelModelById(channelId).then((v) {
      setState(() {
        isModelLoading = false;
        model = v;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            body: Hero(
              tag: heroId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: _buildVideoCardImage(heroImg, heroId),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildVideoCardImage(String url, String id) {
    return Image.network(
      url,
      fit: .contain,
      frameBuilder: (c, child, frame, wasSyncLoaded) {
        if (frame != null || wasSyncLoaded) {
          return child;
        }
        return _buildCoverFallback(c, id);
      },
      errorBuilder: (c, _, _) => _buildCoverFallback(c, id),
    );
  }

  Widget _buildCoverFallback(BuildContext context, String id) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final color = Themes.colorFromId(id, brightness);
    return Container(color: color, alignment: .center);
  }
}
