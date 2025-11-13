import 'package:bingetube/common/widget/custom_dialog.dart';
import 'package:bingetube/core/api/search_api.dart';
import 'package:bingetube/core/api/youtube_data.dart';
import 'package:bingetube/core/utils/secure_storage.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<YouTubeChannel>? channels;

  @override
  Widget build(BuildContext context) {
    var isConfigured = SecureStorage().get(SecureStorageKey.apikey) != null;
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: TextField(
            enabled: isConfigured,
            onSubmitted: (t) => _onSearch(context, t),
            decoration: InputDecoration(
              hintText: 'Search...',
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            if (channels == null)
              Text('No Results. Might be error')
            else
              ...channels!.map((f) => Text(f.title)),
          ],
        ),
      ),
    );
  }

  static num _searchId = 0;
  void _onSearch(BuildContext context, String query) async {
    final apiKey = SecureStorage().get(SecureStorageKey.apikey);
    if (apiKey == null) {
      return;
    }
    final currSearchId = ++_searchId;
    CustomDialog.show(
      context,
      'Fetching channel info',
      'Cancel',
      LinearProgressIndicator(),
    );
    final channelsData = await SearchApi.searchYouTubeChannels(query, apiKey);
    if (context.mounted) {
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
            channels = channelsData;
        });
      }
    }
  }
}
