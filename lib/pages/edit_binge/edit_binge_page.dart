import 'package:bingetube/app/routes.dart';
import 'package:bingetube/core/db/access/videos.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditBingePage extends ConsumerStatefulWidget {
  final Map<String, String> params;

  const EditBingePage(this.params, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditBingePageState();

  static Map<String, String> buildParams(Map<String, String> params) {
    return Map.fromEntries(
      [
        BingeParams.type,
        BingeParams.id,
      ].map((v) => MapEntry(v.name, params[v.name]!)),
    );
  }
}

class _EditBingePageState extends ConsumerState<EditBingePage> {
  late BingeController _controller;
  Set<String> deleteMarked = {};

  @override
  void initState() {
    super.initState();
    _controller = BingeController(widget.params);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 16.0),
        leading: IconButton(
          onPressed: () => Routes.popOrHome(context),
          icon: Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: Text('Edit Binge'),
        actions: [
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.check),
            tooltip: 'Save',
            onPressed: () {},
          ),
        ],
      ),

      body: StreamBuilder(
        stream: _controller.stream,
        builder: (context, snashot) {
          if (!snashot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var videos = snashot.data!.videos;
          videos = videos
              .where((v) => !deleteMarked.contains(v.video.id))
              .toList();
          return SingleChildScrollView(
            child: Column(children: [...videos.map((v) => _buildVideoCard(v))]),
          );
        },
      ),
    );
  }

  Widget _buildVideoCard(VideoModel video) {
    return Card(
      key: Key(video.video.id),
      shape: RoundedRectangleBorder(),
      child: Row(
        children: [
          SizedBox(
            width: 160,
            height: 90,
            child: Stack(
              alignment: .bottomCenter,
              children: [
                Image.network(video.thumbnails.mediumUrl, fit: .cover),
                if (video.progress.isFinished) ...[
                  LinearProgressIndicator(value: 1),
                ],
              ],
            ),
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
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => setState(() {
              deleteMarked.add(video.video.id);
            }),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
