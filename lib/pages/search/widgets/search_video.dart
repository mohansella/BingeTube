import 'package:bingetube/core/api/youtube_api.dart';
import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/binge_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

class SearchVideoWidget extends ConsumerStatefulWidget {
  static final Logger _logger = LogManager.getLogger('SearchVideoWidget');

  final String? query;
  final void Function(ScrollController) scrollListener;

  const SearchVideoWidget(this.query, this.scrollListener, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchVideoState();
}

class _SearchVideoState extends ConsumerState<SearchVideoWidget>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  bool _isValidQuery = false;
  bool _isLoaded = false;
  List<VideoModel>? _videos;

  _SearchVideoState();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var text = '';
    if (!_isValidQuery) {
      text = 'Search Videos to add to your collection';
    } else if (_isLoaded) {
      final videos = _videos;
      if (videos == null) {
        text = 'Some error occured';
      } else if (videos.isEmpty) {
        text = 'No results found';
      } else {
        return SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: [...videos.map((video) => _buildVideoCard(video))],
            ),
          ),
        );
      }
    }

    if (text.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text('Loading...'),
            SizedBox(height: 16),
            FractionallySizedBox(
              widthFactor: 0.4,
              child: LinearProgressIndicator(),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Text(text, textAlign: .center),
      );
    }
  }

  @override
  void didUpdateWidget(covariant SearchVideoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.query != oldWidget.query) {
      setState(() {
        _isValidQuery = false;
        _isLoaded = false;
        _videos = null;
      });
      _processRequest(widget.query);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(
      () => widget.scrollListener(_scrollController),
    );
    _processRequest(widget.query);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Card _buildVideoCard(VideoModel video) {
    return Card(
      clipBehavior: .hardEdge,
      child: InkWell(
        onTap: () {
          context.push(BingePage.buildPath(.singleVideo, video.video.id));
        },
        child: Row(
          children: [
            Image.network(
              video.thumbnails.mediumUrl,
              width: 160,
              height: 90,
              fit: .cover,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    video.snippet.title,
                    maxLines: 2,
                    overflow: .ellipsis,
                    style: TextStyle(fontWeight: .w500),
                  ),
                  Text(
                    video.snippet.channelTitle,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: TextStyle(fontWeight: .w200),
                  ),
                  Text(
                    video.snippet.description,
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

  void _processRequest(String? query) async {
    if (query == null) {
      return;
    }
    setState(() {
      _isValidQuery = true;
    });

    SearchVideoWidget._logger.info('Initiating video search for query: $query');
    final videosResult = await YoutubeApi.searchVideos(ref, query);
    if (query == widget.query) {
      setState(() {
        _videos = videosResult.fold((v) => v, (e) => null);
        _isLoaded = true;
      });
    } else {
      SearchVideoWidget._logger.info(
        'Ignored search results due to user moved to next query:${widget.query} from:$query',
      );
    }
  }
}
