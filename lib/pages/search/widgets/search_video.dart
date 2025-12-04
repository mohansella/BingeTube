import 'package:bingetube/core/api/youtube_api.dart';
import 'package:bingetube/core/api/youtube_data.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

class SearchVideoWidget extends ConsumerStatefulWidget {
  static final Logger _logger = LogManager.getLogger('SearchVideoWidget');

  final String? query;

  const SearchVideoWidget(this.query, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchVideoState();
}

class _SearchVideoState extends ConsumerState<SearchVideoWidget> {
  bool _isValidQuery = false;
  bool _isLoaded = false;
  List<YouTubeVideo>? _videos;

  static MapEntry<String, List<YouTubeVideo>?>? prevResult;

  _SearchVideoState();

  @override
  void initState() {
    super.initState();
    processRequest(widget.query);
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
      processRequest(widget.query);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                ...videos.map((video) {
                  return Card(
                    clipBehavior: .hardEdge,
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Image.network(
                            video.thumbnailUrl,
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
                                  video.title,
                                  maxLines: 2,
                                  overflow: .ellipsis,
                                  style: TextStyle(fontWeight: .w500),
                                ),
                                Text(
                                  video.channelTitle,
                                  maxLines: 1,
                                  overflow: .ellipsis,
                                  style: TextStyle(fontWeight: .w200),
                                ),
                                Text(
                                  video.description,
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
                }),
              ],
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

  void processRequest(String? query) async {
    if (query != null) {
      setState(() {
        _isValidQuery = true;
      });

      if (query == prevResult?.key && prevResult?.value != null) {
        SearchVideoWidget._logger.info(
          'Showing cached result for query:$query',
        );
        setState(() {
          _videos = prevResult?.value;
          _isLoaded = true;
        });
        return;
      }

      SearchVideoWidget._logger.info(
        'Initiating video search for query: $query',
      );
      final apiKey = ref.read(ConfigProviders.apiKeyMeta).apiKey;
      final videos = await YoutubeApi.searchVideos(ref, apiKey, query);
      SearchVideoWidget._logger.info(
        'Found: ${videos?.length ?? -1} videos for query: $query',
      );
      if (query == widget.query) {
        setState(() {
          _videos = videos;
          _isLoaded = true;
          prevResult = MapEntry(query, videos);
        });
      } else {
        SearchVideoWidget._logger.info(
          'Ignored search results due to user moved to next query:${widget.query} from:$query',
        );
      }
    }
  }
}
