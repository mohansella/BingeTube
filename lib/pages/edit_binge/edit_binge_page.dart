import 'package:bingetube/app/routes.dart';
import 'package:bingetube/common/widget/refine/refine_widget.dart';
import 'package:bingetube/core/binge/binge_filter.dart';
import 'package:bingetube/core/binge/binge_sort.dart';
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
  Set<String> checkMarked = {};

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
    return StreamBuilder(
      stream: _controller.stream,
      builder: (context, snashot) {
        if (!snashot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        var videos = snashot.data!.videos;
        return Scaffold(
          appBar: _buildAppBar(context, videos),
          body: _buildList(videos),
        );
      },
    );
  }

  SingleChildScrollView _buildList(List<VideoModel> videos) {
    return SingleChildScrollView(
      child: Column(children: [...videos.map((v) => _buildVideoCard(v))]),
    );
  }

  AppBar _buildAppBar(BuildContext context, List<VideoModel> videos) {
    return AppBar(
      actionsPadding: EdgeInsets.only(right: 16.0),
      leading: IconButton(
        onPressed: () => Routes.popOrHome(context),
        icon: Icon(Icons.arrow_back),
        tooltip: 'Back',
      ),
      title: _buildTitle(context, videos),
      actions: [
        IconButton(
          color: Theme.of(context).colorScheme.primary,
          icon: const Icon(Icons.check),
          tooltip: 'Save',
          onPressed: () {},
        ),
      ],
      bottom: _buildAppBarBottom(),
    );
  }

  Column _buildTitle(BuildContext context, List<VideoModel> videos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Edit Binge',
          maxLines: 1,
          overflow: .ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          '${videos.length} videos',
          maxLines: 1,
          overflow: .ellipsis,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.white70),
        ),
      ],
    );
  }

  PreferredSize _buildAppBarBottom() {
    return PreferredSize(
      preferredSize: Size.fromHeight(44.0),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Icon(Icons.done_all),
            ),
            Expanded(
              child: BingeRefineWidget(
                filter: _controller.filter,
                sort: _controller.sort,
                minDateTime: _controller.minDateTime,
                maxDateTime: _controller.maxDateTime,
                onFilterUpdate: _onFilterModified,
                onSortUpdate: _onSortModified,
                onShowModal: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCard(VideoModel video) {
    final isChecked = checkMarked.contains(video.video.id);
    return Card(
      key: Key(video.video.id),
      shape: RoundedRectangleBorder(),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                isChecked ? Icons.check_box : Icons.check_box_outline_blank,
              ),
              tooltip: isChecked ? 'Mark Unchecked' : 'Mark Checked',
              onPressed: () => setState(() {
                if (isChecked) {
                  checkMarked.remove(video.video.id);
                } else {
                  checkMarked.add(video.video.id);
                }
              }),
            ),
          ),
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
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  void _onFilterModified(BingeFilter filter) {
    setState(() {
      _controller.setFilter(filter);
    });
  }

  void _onSortModified(BingeSort sort) {
    setState(() {
      _controller.setSort(sort);
    });
  }
}
