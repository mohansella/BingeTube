import 'package:bingetube/core/api/youtube_api.dart';
import 'package:bingetube/core/db/access/search.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/channel/channel_page.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

class SearchChannelWidget extends ConsumerStatefulWidget {
  static final Logger _logger = LogManager.getLogger('SearchChannelWidget');

  final String? query;
  final void Function(ScrollController) scrollListener;

  const SearchChannelWidget(this.query, this.scrollListener, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchChannelState();
}

class _SearchChannelState extends ConsumerState<SearchChannelWidget>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  bool _isValidQuery = false;
  bool _isLoaded = false;
  ChannelSearchModel? _model;

  _SearchChannelState();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var text = '';
    if (!_isValidQuery) {
      text = 'Search channels to add to your collection';
    } else if (_isLoaded) {
      if (_model == null) {
        text = 'Some error occured';
      } else if (_model!.channels.isEmpty) {
        text = 'No results found';
      } else {
        final channels = _model!.channels;
        return ListView.builder(
          controller: _scrollController,
          itemCount: channels.length,
          itemBuilder: (context, index) {
            final channel = channels[index];
            return Card(
              child: InkWell(
                onTap: () {
                  final params = ChannelPage.buildParams(
                    channelId: channel.channel.id,
                    heroId: channel.channel.id,
                    heroImg: channel.thumbnails.defaultUrl,
                  );
                  context.pushNamed(
                    Pages.channel.name,
                    queryParameters: params,
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    foregroundImage: NetworkImage(
                      channel.thumbnails.defaultUrl,
                    ),
                  ),
                  title: Text(channel.snippet.title),
                  subtitle: Text(
                    channel.snippet.description,
                    maxLines: 2,
                    overflow: .ellipsis,
                    style: TextStyle(fontWeight: .w300),
                  ),
                  mouseCursor: SystemMouseCursors.click,
                ),
              ),
            );
          },
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
  void didUpdateWidget(covariant SearchChannelWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.query != oldWidget.query) {
      setState(() {
        _isValidQuery = false;
        _isLoaded = false;
        _model = null;
      });
      processRequest(widget.query);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(
      () => widget.scrollListener(_scrollController),
    );
    processRequest(widget.query);
  }

  void processRequest(String? query) async {
    if (query == null) {
      return;
    }

    setState(() {
      _isValidQuery = true;
    });

    SearchChannelWidget._logger.info(
      'Initiating channel search for query: $query',
    );
    final channelsResult = await YoutubeApi.searchChannels(ref, query);
    if (query == widget.query) {
      final channels = channelsResult.fold((l) => l, (e) => null);
      setState(() {
        _model = channels;
        _isLoaded = true;
      });
    } else {
      SearchChannelWidget._logger.info(
        'Ignored search results due to user moved to next query:${widget.query} from:$query',
      );
    }
  }
}
