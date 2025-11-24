import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends ConsumerState<SearchPage> {
  bool _isConfigured = false;

  @override
  void initState() {
    super.initState();
    _isConfigured = ref.read(ConfigProviders.apiKeyMeta).apiKey.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: TextField(
            enabled: _isConfigured,
            decoration: InputDecoration(
              hintText: 'Search...',
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Channels'),
                Tab(text: 'Videos'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(child: const Text('Channels result')),
                  SingleChildScrollView(child: const Text('Videos result')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
