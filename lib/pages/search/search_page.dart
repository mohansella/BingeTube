import 'package:bingetube/common/widget/custom_dialog.dart';
import 'package:bingetube/core/api/search_api.dart';
import 'package:bingetube/core/api/youtube_data.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends ConsumerState<SearchPage> {
  List<bool> _selected = [true, false];
  get isChannelSearch => _selected[0];

  List<YouTubeChannel>? _channels;
  List<YouTubeVideo>? _videos;

  @override
  Widget build(BuildContext context) {
    var isConfigured = ref.watch(ConfigProviders.apiKeyMeta).apiKey.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: TextField(
            enabled: isConfigured,
            onSubmitted: (t) => _onSearch(context, t),
            decoration: InputDecoration(
              hintText: 'Search...',
              suffixIcon: ToggleButtons(
                isSelected: _selected,
                children: [
                  Icon(Icons.account_circle_outlined),
                  Icon(Icons.video_library_outlined),
                ],
                onPressed: (i) {
                  setState(() {
                    _selected = [false, false];
                    _selected[i] = true;
                  });
                },
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isConfigured) ...[
              if (isChannelSearch) ...[
                if (_channels != null) ...[
                  ..._channels!.map((c) => buildChannel(c, context)),
                ],
              ] else ...[
                if (_videos != null) ...[
                  ..._videos!.map((v) => buildVideo(v, context)),
                ],
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget buildChannel(YouTubeChannel channel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: Image.network(
                  channel.thumbnailUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),

              // Texts
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        channel.title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        channel.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildVideo(YouTubeVideo video, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail with play overlay
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      video.thumbnailUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Text content
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      video.channelTitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      video.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Published: ${video.publishedAt.toLocal().toString().split(' ')[0]}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  num _searchId = 0;
  Future<void> _onSearch(BuildContext context, String query) async {
    setState(() {
      _channels = null;
      _videos = null;
    });
    final apiKey = ref.read(ConfigProviders.apiKeyMeta).apiKey;
    if (apiKey.isEmpty) {
      return;
    }
    if (isChannelSearch) {
      await _onChannelSearch(context, query, apiKey);
    } else {
      await _onVideoSearch(context, query, apiKey);
    }
  }

  Future<void> _onChannelSearch(
    BuildContext context,
    String query,
    String apiKey,
  ) async {
    final currSearchId = ++_searchId;
    CustomDialog.show(
      context,
      'Fetching channel info',
      'Cancel',
      LinearProgressIndicator(),
    );
    final channelsData = await SearchApi.searchYouTubeChannels(query, apiKey);
    if (context.mounted && currSearchId == _searchId) {
      Navigator.pop(context);
      if (channelsData == null) {
        CustomDialog.show(
          context,
          'Error while fetching channels',
          'Okay',
          null,
        );
      } else {
        setState(() {
          _channels = channelsData;
        });
      }
    }
  }

  Future<void> _onVideoSearch(
    BuildContext context,
    String query,
    String apiKey,
  ) async {
    final currSearchId = ++_searchId;
    CustomDialog.show(
      context,
      'Fetching videos info',
      'Cancel',
      LinearProgressIndicator(),
    );
    final videosData = await SearchApi.searchYouTubeVideos(query, apiKey);
    if (context.mounted && currSearchId == _searchId) {
      Navigator.pop(context);
      if (videosData == null) {
        CustomDialog.show(context, 'Error while fetching videos', 'Okay', null);
      } else {
        setState(() {
          _videos = videosData;
        });
      }
    }
  }
}
