import 'package:bingetube/app/theme.dart';
import 'package:bingetube/core/db/access/channels.dart';
import 'package:bingetube/core/db/access/playlists.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:flutter/material.dart';
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
  final _channelDao = ChannelsDao(Database());
  final _playlistDao = PlaylistsDao(Database());

  late String _channelId;
  late String _heroId;
  late String _heroImg;

  bool _isModelLoading = true;
  late ChannelModel _model;
  late double _width;

  @override
  void initState() {
    super.initState();
    final params = widget.queryParameters;
    _channelId = params[_Params.channelId.name]!;
    _heroId = params[_Params.heroId.name]!;
    _heroImg = params[_Params.heroImg.name]!;

    _channelDao.getChannelModelById(_channelId).then((v) {
      setState(() {
        _isModelLoading = false;
        _model = v;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _width = constraints.minWidth;
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Column(
              crossAxisAlignment: .stretch,
              children: [ _buildChannelInfo(), _buildPlaylist()]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaylist() {
    return Align(
      alignment: .center,
      child: StreamBuilder(
        stream: _playlistDao.streamPlaylistModels(_channelId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final data = snapshot.data!;
          var list = data.normals;
          if (data.uploads != null) {
            list = [data.uploads!, ...list];
          }
          if (data.likes != null) {
            list = [data.likes!, ...list];
          }
          if (list.isEmpty) {
            return Text('No playlist available');
          } else {
            return ListView.builder(
              itemBuilder: (context, i) {
                final curr = list[i];
                return ListTile(title: Text(curr.snippet.title));
              },
            );
          }
        },
      ),
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
                tag: _heroId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: _buildVideoCardImage(_heroImg, _heroId),
                ),
              ),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: .start,
                children: [
                  if (!_isModelLoading) ...[
                    Text(
                      _model.snippet.title,
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
          if (!_isModelLoading) ...[
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReadMoreText(
                _model.snippet.description,
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
    if (!_model.statistics.hiddenSubscriberCount) {
      final count = _model.statistics.subscriberCount;
      _writeShortNumber(count, buffer);
      buffer.write(' subscribers * ');
    }
    _writeShortNumber(_model.statistics.videoCount, buffer);
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
