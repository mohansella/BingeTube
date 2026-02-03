import 'package:bingetube/app/theme.dart';
import 'package:bingetube/common/widget/custom_dialog.dart';
import 'package:bingetube/core/api/youtube_api.dart';
import 'package:bingetube/core/constants/constants.dart';
import 'package:bingetube/core/db/access/channels.dart';
import 'package:bingetube/core/db/access/playlists.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/binge_page.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readmore/readmore.dart';

enum _Params { channelId, heroId, heroImg }

class ChannelPage extends ConsumerStatefulWidget {
  static final _logger = LogManager.getLogger('ChannelPage');

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
  bool _isFetchTriggered = false;
  late ChannelModel _model;

  bool _isFetchInProgress = false;
  late int _fetchCount;
  late int _fetchTotal;
  double get _progress {
    if (_fetchTotal == 0) return 0;
    return (_fetchCount / _fetchTotal).clamp(0.0, 1.0);
  }

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              _buildChannelInfo(),
              ..._buildProgress(),
              _buildPlaylistStream(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildProgress() {
    return [
      if (_isFetchInProgress) ...[
        LinearProgressIndicator(value: _progress),
        const SizedBox(height: 4),
        Text(
          '$_fetchCount / $_fetchTotal playlists updated',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ] else ...[
        SizedBox(height: 24),
      ],
    ];
  }

  Widget _buildPlaylistStream() {
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

          _triggerSyncIfNeeded(list);

          if (list.isEmpty && !_isFetchInProgress) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('No playlist available'),
            );
          }
          return _buildPlaylistRaw(list);
        },
      ),
    );
  }

  ListView _buildPlaylistRaw(List<PlaylistModel> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, i) {
        return _buildPlaylistCard(context, list[i]);
      },
    );
  }

  Widget _buildPlaylistCard(BuildContext contet, PlaylistModel model) {
    final imgUrl = model.thumbnails.highUrl;
    return Card(
      clipBehavior: .hardEdge,
      child: InkWell(
        onTap: () => _onTapPlaylist(model, imgUrl),
        child: Row(
          children: [
            _buildPlaylistImages(model, imgUrl),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    model.snippet.title,
                    maxLines: 2,
                    overflow: .ellipsis,
                    style: TextStyle(fontWeight: .w500),
                  ),
                  Text(
                    '${model.details.itemCount} videos',
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: TextStyle(fontWeight: .w200),
                  ),
                  Text(
                    model.snippet.description,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: TextStyle(fontWeight: .w300),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaylistImages(PlaylistModel model, String imgUrl) {
    final id = model.playlist.id;
    return Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: .only(top: 0.0),
            child: ClipRRect(
              borderRadius: .circular(10),
              child: _buildPlaylistImageFallback(id, alpha: 0.5),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: .only(top: 3.0),
            child: ClipRRect(
              borderRadius: .circular(10),
              child: _buildPlaylistImageFallback(id, alpha: 0.9),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: ClipRRect(
            borderRadius: .circular(10),
            child: Hero(tag: id, child: _buildPlaylistImage(model, imgUrl)),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaylistImage(PlaylistModel model, String imgUrl) {
    return Image.network(
      imgUrl,
      fit: .cover,
      height: 90,
      width: 160,
      frameBuilder: (c, child, frame, wasSyncLoaded) {
        if (frame != null || wasSyncLoaded) {
          return child;
        }
        return _buildPlaylistImageFallback(model.snippet.id);
      },
      errorBuilder: (c, _, _) => _buildPlaylistImageFallback(model.snippet.id),
    );
  }

  Widget _buildPlaylistImageFallback(String id, {double alpha = 1.0}) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final color = Themes.colorFromId(id, brightness, alpha: alpha, sat: 0.1);
    return Container(color: color, alignment: .center);
  }

  Future<void> _triggerSyncIfNeeded(List<PlaylistModel> list) async {
    if (_isFetchTriggered) {
      return;
    }
    final nowTime = DateTime.now();
    bool isAnyExpired = list.any((p) {
      final expiresAt = p.playlist.updatedAt.add(
        CacheConstants.syncChannelSearchResultAfter,
      );
      return expiresAt.isBefore(nowTime);
    });

    if (list.isEmpty || isAnyExpired) {
      _isFetchTriggered = true;
      await Future.delayed(Duration.zero);
      setState(() {
        _isFetchInProgress = true;
        _fetchCount = 0;
        _fetchTotal = 1;
      });
      ChannelPage._logger.info(
        'triggering fetch. isAnyExpired:$isAnyExpired existing length:${list.length}',
      );
      YoutubeApi.syncPlaylist(ref, _channelId, (count, total) {
        setState(() {
          _fetchCount = count;
          _fetchTotal = total;
        });
        return context.mounted;
      }).whenComplete(() {
        setState(() {
          _isFetchInProgress = false;
        });
      });
    }
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
                  child: _buildChannelImage(_heroImg, _heroId),
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

  Widget _buildChannelImage(String url, String id) {
    return Image.network(
      url,
      fit: .contain,
      frameBuilder: (_, child, frame, wasSyncLoaded) {
        if (frame != null || wasSyncLoaded) {
          return child;
        }
        return _buildChannelImageFallback(id);
      },
      errorBuilder: (c, _, _) => _buildChannelImageFallback(id),
    );
  }

  Widget _buildChannelImageFallback(String id) {
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

  void _onTapPlaylist(PlaylistModel model, String imgUrl) async {
    final id = model.playlist.id;
    final isCompleted = await _syncVideosWithCustomDialogProgress(model);
    if (!isCompleted) {
      return;
    }
    final firstVideo = await _playlistDao.getFirstVideoModel(id);
    final lContext = context;
    if (lContext.mounted) {
      lContext.pushNamed(
        Pages.binge.name,
        queryParameters: BingePage.buildParams(
          type: .playlistVideos,
          id: id,
          videoId: firstVideo.video.id,
          heroId: id,
          heroImg: imgUrl,
        ),
      );
    }
  }

  Future<bool> _syncVideosWithCustomDialogProgress(PlaylistModel model) async {
    var isSync = false;
    var progress = 0;
    var end = 1;

    bool Function(bool, int, int) callback = (s, p, e) => true;
    bool callbackWrapper(s, p, e) => callback(s, p, e);
    final future = YoutubeApi.syncPlaylistVideos(
      ref,
      model.playlist.id,
      callbackWrapper,
    );

    final isCancelled = await CustomDialog.show(
      context,
      'Syncing playlist items',
      'Cancel',
      FutureBuilder(
        future: future,
        builder: (fContext, snapshot) {
          if (snapshot.hasData && fContext.mounted) {
            Future.microtask(() {
              if (fContext.mounted) fContext.pop();
            });
          }
          return StatefulBuilder(
            builder: (localContext, setLocalState) {
              callback = (s, p, e) {
                Future.microtask(() {
                  if (!localContext.mounted) return;
                  setLocalState(() {
                    isSync = s;
                    progress = p;
                    end = e;
                  });
                });
                return localContext.mounted;
              };
              return Column(
                mainAxisSize: .min,
                children: [
                  Text('${isSync ? "fetching" : "synching"} - $progress/$end'),
                  SizedBox(height: 8),
                  LinearProgressIndicator(value: progress / end),
                ],
              );
            },
          );
        },
      ),
    );
    ChannelPage._logger.info(
      'playlist sync dialog closed. isCancelled:$isCancelled',
    );
    return !isCancelled;
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
