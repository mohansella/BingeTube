import 'package:bingetube/app/theme.dart';
import 'package:bingetube/core/db/access/channels.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readmore/readmore.dart';

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
  late double width;

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
        width = constraints.minWidth;
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Column(children: [_buildChannelInfo()]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChannelInfo() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            mainAxisSize: .min,
            children: [
              Hero(
                tag: heroId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: _buildVideoCardImage(heroImg, heroId),
                ),
              ),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: .start,
                children: [
                  if (!isModelLoading) ...[
                    Text(
                      model.snippet.title,
                      style: theme.textTheme.titleLarge,
                    ),
                    Text(
                      _buildSubsAndVideosText(),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          if (!isModelLoading) ...[
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReadMoreText(
                model.snippet.description,
                style: theme.textTheme.bodySmall,
                trimLines: 2,
                trimMode: .Line,
                
              ),
            ),
          ],
        ],
      ),
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

  String _buildSubsAndVideosText() {
    final buffer = StringBuffer();
    if (!model.statistics.hiddenSubscriberCount) {
      final count = model.statistics.subscriberCount;
      _writeShortNumber(count, buffer);
      buffer.write(' subscribers * ');
    }
    _writeShortNumber(model.statistics.videoCount, buffer);
    buffer.write(' videos');

    return buffer.toString();
  }

  void _writeShortNumber(int count, StringBuffer buffer) {
    if (count >= 1000000) {
      buffer.write('${(count / 1000000).toStringAsFixed(1)}M');
    } else if (count >= 1000) {
      buffer.write('${(count / 1000).toStringAsFixed(1)}K');
    } else {
      buffer.write(count.toString());
    }
  }
}
