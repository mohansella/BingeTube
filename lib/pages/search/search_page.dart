import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/pages/search/widgets/search_channel.dart';
import 'package:bingetube/pages/search/widgets/search_video.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends ConsumerState<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _textController;
  late String apiKey;

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
    apiKey = ref.read(ConfigProviders.apiKeyMeta).apiKey;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    apiKey = ref.read(ConfigProviders.apiKeyMeta).apiKey;
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: TextField(
            autofocus: true,
            enabled: apiKey.isNotEmpty,
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
          if (apiKey.isNotEmpty) ...[
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: 8),
                      Text('Channels'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.ondemand_video),
                      SizedBox(width: 8),
                      Text('Videos'),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SearchChannelWidget(_searchQuery),
                  SearchVideoWidget(_searchQuery),
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
