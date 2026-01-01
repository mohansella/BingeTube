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
  final Set<String> _checkMarked = {};
  bool _showTitle = false;

  TextEditingController? _editTitleController;
  TextEditingController? _editDescriptionController;

  @override
  void initState() {
    super.initState();
    _controller = BingeController(widget.params);
  }

  @override
  void dispose() {
    _controller.dispose();
    _editTitleController?.dispose();
    _editDescriptionController?.dispose();
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
        final model = snashot.data!;
        final videos = model.videos;
        return Scaffold(
          appBar: _buildAppBar(context, model),
          body: SingleChildScrollView(
            child: Column(children: _buildList(videos)),
          ),
        );
      },
    );
  }

  List<Widget> _buildList(List<VideoModel> videos) {
    return videos.map((v) => _buildVideoCard(v)).toList();
  }

  AppBar _buildAppBar(BuildContext context, BingeModel model) {
    return AppBar(
      actionsPadding: EdgeInsets.only(right: 16.0),
      leading: IconButton(
        onPressed: () => Routes.popOrHome(context),
        icon: Icon(Icons.arrow_back),
        tooltip: 'Back',
      ),
      title: _buildTitle(context, model),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              _showTitle = !_showTitle;
            });
          },
          icon: Icon(_showTitle ? Icons.expand_less : Icons.expand_more),
        ),
        IconButton(
          color: Theme.of(context).colorScheme.primary,
          icon: const Icon(Icons.check),
          tooltip: 'Save',
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(_showTitle ? 124 : 50),
        child: Center(
          child: Column(
            children: [
              if (_showTitle) ...[_buildEditTitle(model)],
              _buildAppBarBottom(model),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditTitle(BingeModel model) {
    _editTitleController ??= TextEditingController(text: model.title);
    _editDescriptionController ??= TextEditingController(
      text: model.description,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            maxLines: 1,
            autofocus: true,
            controller: _editTitleController,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            decoration: const InputDecoration.collapsed(
              hintText: 'Binge title',
            ),
          ),

          const SizedBox(height: 6),

          TextField(
            maxLines: 1,
            controller: _editDescriptionController,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            decoration: const InputDecoration.collapsed(
              hintText: 'Description',
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, BingeModel model) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: Column(
          children: [
            Text(
              'Edit Binge',
              maxLines: 1,
              overflow: .ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '${model.videos.length} videos',
              maxLines: 1,
              overflow: .ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarBottom(BingeModel model) {
    final isAllSelected = model.videos.every(
      (v) => _checkMarked.contains(v.video.id),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 18.0),
            child: IconButton(
              onPressed: () => setState(() {
                final videoIds = model.videos.map((v) => v.video.id);
                if (isAllSelected) {
                  _checkMarked.removeAll(videoIds);
                } else {
                  _checkMarked.addAll(videoIds);
                }
              }),
              icon: Icon(
                isAllSelected ? Icons.check_box_outline_blank : Icons.done_all,
              ),
              tooltip: isAllSelected ? 'Deselect All' : 'Select All',
            ),
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
    );
  }

  Widget _buildVideoCard(VideoModel video) {
    final isChecked = _checkMarked.contains(video.video.id);
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
                  _checkMarked.remove(video.video.id);
                } else {
                  _checkMarked.add(video.video.id);
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
