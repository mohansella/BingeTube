import 'package:bingetube/core/api/youtube_api.dart';
import 'package:bingetube/core/db/access/channels.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

class SearchChannelWidget extends ConsumerStatefulWidget {
  static final Logger _logger = LogManager.getLogger('SearchChannelWidget');

  final String? query;

  const SearchChannelWidget(this.query, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchChannelState();
}

class _SearchChannelState extends ConsumerState<SearchChannelWidget> {
  bool _isValidQuery = false;
  bool _isLoaded = false;
  List<ChannelModel>? _channels;

  _SearchChannelState();

  @override
  void initState() {
    super.initState();
    processRequest(widget.query);
  }

  @override
  void didUpdateWidget(covariant SearchChannelWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.query != oldWidget.query) {
      setState(() {
        _isValidQuery = false;
        _isLoaded = false;
        _channels = null;
      });
      processRequest(widget.query);
    }
  }

  @override
  Widget build(BuildContext context) {
    var text = '';
    if (!_isValidQuery) {
      text = 'Search channels to add to your collection';
    } else if (_isLoaded) {
      final channels = _channels;
      if (channels == null) {
        text = 'Some error occured';
      } else if (channels.isEmpty) {
        text = 'No results found';
      } else {
        return ListView.builder(
          itemCount: channels.length,
          itemBuilder: (context, index) {
            final channel = channels[index];
            return Card(
              child: InkWell(
                onTap: () {},
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
        _channels = channels;
        _isLoaded = true;
      });
    } else {
      SearchChannelWidget._logger.info(
        'Ignored search results due to user moved to next query:${widget.query} from:$query',
      );
    }
  }
}
