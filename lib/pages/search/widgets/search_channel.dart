import 'package:bingetube/core/api/youtube_api.dart';
import 'package:bingetube/core/api/youtube_data.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

class SearchChannelWidget extends ConsumerStatefulWidget {
  static final Logger logger = LogManager.getLogger('SearchChannelWidget');

  final String? query;

  const SearchChannelWidget(this.query, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchChannelState();
}

class _SearchChannelState extends ConsumerState<SearchChannelWidget> {
  bool _isValidQuery = false;
  bool _isLoaded = false;
  List<YouTubeChannel>? _channels;

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
    var text = 'loading...';
    if (!_isValidQuery) {
      text = 'Search channels to add to your collection';
    } else if (_isLoaded) {
      final channels = _channels;
      if (channels == null) {
        text = 'Some error occured';
      } else if (channels.isEmpty) {
        text = 'No results found';
      } else {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                ...channels.map((channel) {
                  return Card(
                    child: InkWell(
                      onTap: () {},
                      child: ListTile(
                        title: Text(channel.title),
                        subtitle: Text(
                          '@${channel.id} * ${channel.description}',
                        ),
                        leading: Image.network(channel.thumbnailUrl),
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

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Text(text, textAlign: .center),
    );
  }

  void processRequest(String? query) async {
    if (query != null) {
      setState(() {
        _isValidQuery = true;
      });
      SearchChannelWidget.logger.info(
        'Initiating channel search for query: $query',
      );
      final apiKey = ref.read(ConfigProviders.apiKeyMeta).apiKey;
      final channels = await YoutubeApi.searchChannels(apiKey, query);
      SearchChannelWidget.logger.info(
        'Found: ${channels?.length ?? -1} channels for query: $query',
      );
      if (query == widget.query) {
        setState(() {
          _isLoaded = true;
          _channels = channels;
        });
      } else {
        SearchChannelWidget.logger.info(
          'Ignored search results due to user moved to next query:${widget.query} from:$query',
        );
      }
    }
  }
}
