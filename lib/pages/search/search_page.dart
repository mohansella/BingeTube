import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

class SearchPage extends ConsumerStatefulWidget {
  static final Logger logger = LogManager.getLogger('SearchPage');

  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends ConsumerState<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _textController;

  String? _searchQuery;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: Duration(milliseconds: 250),
    );
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyConfigured = ref
        .watch(ConfigProviders.apiKeyMeta)
        .apiKey
        .isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: TextField(
            autofocus: true,
            enabled: isKeyConfigured,
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Search...',
              suffixIcon: Icon(Icons.search),
            ),
            onTapOutside: (event) {
              _textController.text = _searchQuery ?? '';
              FocusScope.of(context).unfocus();
            },
            onSubmitted: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
          ),
        ),
      ),
      body: Column(
        children: [
          if (isKeyConfigured) ...[
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Channels'),
                Tab(text: 'Videos'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _SearchChannelPage(query: _searchQuery),
                  _SearchVideoPage(query: _searchQuery),
                ],
              ),
            ),
          ] else ...[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: const Text(
                  'Add your YouTube API key to start searching',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SearchChannelPage extends ConsumerStatefulWidget {
  final String? query;

  const _SearchChannelPage({required this.query});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchChannelPageState();
}

class _SearchChannelPageState extends ConsumerState<_SearchChannelPage> {
  @override
  Widget build(BuildContext context) {
    if(widget.query?.isEmpty ?? true) {
      return Text('search channel');
    } else {
      SearchPage.logger.info('Channel Search: ${widget.query}');
      return Text('search channel for result: ${widget.query}');
    }
  }
}

class _SearchVideoPage extends ConsumerStatefulWidget {
  final String? query;

  const _SearchVideoPage({required this.query});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchVideoPageState();
}

class _SearchVideoPageState extends ConsumerState<_SearchVideoPage> {
  @override
  Widget build(BuildContext context) {
    if(widget.query?.isEmpty ?? true) {
      return Text('search video');
    } else {
      SearchPage.logger.info('Video Search: ${widget.query}');
      return Text('search video for result: ${widget.query}');
    }
  }
}
