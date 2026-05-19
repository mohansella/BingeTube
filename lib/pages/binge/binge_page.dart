import 'package:bingetube/app/routes.dart';
import 'package:bingetube/common/widget/binge/binge_video_entry.dart';
import 'package:bingetube/common/widget/binge/choose_collection.dart';
import 'package:bingetube/common/widget/custom_dialog.dart';
import 'package:bingetube/common/widget/player/player_widget.dart';
import 'package:bingetube/common/widget/refine/refine_widget.dart';
import 'package:bingetube/core/binge/binge_filter.dart';
import 'package:bingetube/core/binge/binge_sort.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/db/models/binge_model.dart';
import 'package:bingetube/core/db/models/video_model.dart';
import 'package:bingetube/core/db/port/sery_port.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:bingetube/pages/edit_binge/edit_binge_page.dart';
import 'package:bingetube/pages/page_route.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BingePage extends ConsumerStatefulWidget {
  static final _logger = LogManager.getLogger('BingePage');

  final Map<String, String> params;

  const BingePage(this.params, {super.key});

  @override
  ConsumerState createState() => _BingePageState();

  static Map<String, String> buildParams({
    required BingeType type,
    required String id,
    required String videoId,
    required String heroId,
    required String heroImg,
  }) {
    return BingeController.updateParams(
      type: type,
      id: id,
      videoId: videoId,
      heroId: heroId,
      heroImg: heroImg,
    );
  }

  static PageGoRoute goRoute() {
    return PageGoRoute(
      page: .binge,
      customBuilder: (_, s) => BingePage(s.uri.queryParameters),
    );
  }
}

class _BingePageState extends ConsumerState<BingePage> {
  final _parentScroll = ScrollController();
  final _childScroll = ScrollController();
  late BingeController _controller;

  double _playerHeight = 0;
  bool _isCollapsed = false;

  bool _showRefine = false;

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
      builder: (context, snapshot) {
        return SafeArea(
          child: Scaffold(
            body: PlayerWidget(
              playerType: ref.read(ConfigProviders.playerType),
              videoId: _controller.activeVideoId,
              controller: _controller,
              parentScroll: _parentScroll,
              childScroll: _childScroll,
              onEvent: (event, {data}) => _onPlayerEvent(context, event, data: data),
              slivers: [
                _buildPlaylistHeader(context, snapshot),
                _buildPlaylist(context, snapshot),
              ],
              isCollapsed: _isCollapsed,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaylist(BuildContext context, AsyncSnapshot<BingeModel> snapshot) {
    if (snapshot.hasError) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: _buildStateView(
          icon: Icons.error_outline,
          title: 'Unable to load playlist',
          message: '${snapshot.error}',
        ),
      );
    }

    if (snapshot.hasData) {
      final videos = snapshot.data!.videos;
      if (videos.isEmpty) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: _buildStateView(
            icon: Icons.playlist_remove_outlined,
            title: 'No playlist entries',
            message: 'This binge does not have any synced videos yet.',
          ),
        );
      }

      return SliverPadding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 24),
        sliver: SliverList.builder(
          itemCount: videos.length * 2 - 1,
          itemBuilder: (context, index) {
            if (index.isOdd) {
              return const SizedBox(height: 8);
            }
            final pos = index ~/ 2;
            return _buildVideoCard(context, videos[pos], pos);
          },
        ),
      );
    }

    return SliverFillRemaining(
      hasScrollBody: false,
      child: _buildStateView(
        icon: Icons.playlist_play_outlined,
        title: 'Loading playlist',
        message: 'Getting your queue ready.',
        isLoading: true,
      ),
    );
  }

  Widget _buildPlaylistHeader(BuildContext context, AsyncSnapshot<BingeModel> snapshot) {
    double headerHeight = _calcHeaderHeight();
    return SliverPersistentHeader(
      pinned: true,
      delegate: _BingeTitleDelegate(
        minHeight: headerHeight,
        maxHeight: headerHeight,
        child: _buildHeaderShell(context, snapshot),
      ),
    );
  }

  Widget _buildHeaderShell(BuildContext context, AsyncSnapshot<BingeModel> snapshot) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
          child: Column(
            children: [
              SizedBox(
                height: 54,
                child: Row(
                  children: [
                    _buildCollapseIcon(),
                    const SizedBox(width: 4),
                    _buildTitleColumn(snapshot),
                    const SizedBox(width: 8),
                    _buildFilterAndModify(snapshot),
                  ],
                ),
              ),
              if (_showRefine)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _buildRefine(snapshot),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRefine(AsyncSnapshot<BingeModel> snapshot) {
    if (!snapshot.hasData) {
      return const SizedBox(height: 36);
    }

    return BingeRefineWidget(
      filter: _controller.filter,
      sort: _controller.sort,
      minDateTime: _controller.minDateTime,
      maxDateTime: _controller.maxDateTime,
      onFilterUpdate: _onFilterModified,
      onSortUpdate: _onSortModified,
      onShowModal: _onRefineOpened,
    );
  }

  double _calcHeaderHeight() {
    final fontSize = ref.read(ConfigProviders.appFontSize);
    const baseHeight = 76.0;
    var headerHeight = _showRefine ? 122.0 : baseHeight;
    if (fontSize == .large) {
      headerHeight += 10.0;
    } else if (fontSize == .small) {
      headerHeight -= 4.0;
    }
    return headerHeight;
  }

  Widget _buildTitleColumn(AsyncSnapshot<BingeModel> snapshot) {
    final theme = Theme.of(context);
    final model = snapshot.data;
    final activePos = _controller.activeVideoPos;
    final count = model?.videos.length ?? 0;
    final activeLabel = activePos == null ? null : 'Playing ${activePos + 1} of $count';

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model?.title.isNotEmpty == true ? model!.title : 'Binge playlist',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(
            activeLabel ?? '$count playlist entries',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapseIcon() {
    return IconButton(
      tooltip: _isCollapsed ? 'Expand' : 'Collapse',
      onPressed: _onCollapsePressed,
      icon: AnimatedRotation(
        turns: _isCollapsed ? 0 : 0.5,
        duration: Duration(milliseconds: 200),
        child: Icon(Icons.expand_less),
      ),
    );
  }

  Widget _buildFilterAndModify(AsyncSnapshot<BingeModel> snapshot) {
    return FutureBuilder(
      future: _controller.supportedActions(),
      builder: (_, actionSnap) {
        if (!actionSnap.hasData) {
          return Row(mainAxisAlignment: .end);
        }
        final actions = actionSnap.data!;
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              tooltip: 'Filter & Sort',
              onPressed: _onFilterPressed,
              icon: Icon(Icons.tune),
            ),
            if (actions.length == 1 && actions[0] == .add) ...[
              IconButton(
                tooltip: 'Add',
                onPressed: () => _onActionAdd(),
                icon: Icon(Icons.add),
              ),
            ] else ...[
              PopupMenuButton(
                tooltip: 'Actions',
                icon: Icon(Icons.more_vert),
                itemBuilder: (_) => _buildMenuItems(snapshot, actions),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildVideoCard(BuildContext context, VideoModel video, int index) {
    final isActive = video.video.id == _controller.activeVideoId;
    return BingeVideoEntry(
      video: video,
      position: index + 1,
      isActive: isActive,
      onTap: isActive ? null : () => _onVideoCardTap(context, video),
      onWatchedPressed: () =>
          _controller.setVideoWatched(video, !video.progressData.isFinished),
    );
  }

  Widget _buildStateView({
    required IconData icon,
    required String title,
    required String message,
    bool isLoading = false,
  }) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 24, 32, 96),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    )
                  : Icon(icon, size: 30, color: theme.colorScheme.onSecondaryContainer),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PopupMenuItem<BingeActions>> _buildMenuItems(
    AsyncSnapshot<BingeModel> snapshot,
    List<BingeActions> actions,
  ) {
    IconData icon;
    String lable;
    final toReturn = <PopupMenuItem<BingeActions>>[];
    for (final action in actions) {
      switch (action) {
        case .add:
          icon = Icons.add;
          lable = 'Icon';
          break;
        case .edit:
          icon = Icons.edit;
          lable = 'Edit';
          break;
        case .moveTo:
          icon = Icons.drive_file_move_outline;
          lable = 'Move to';
          break;
        case .duplicate:
          icon = Icons.content_copy;
          lable = 'Duplicate';
          break;
        case .delete:
          icon = Icons.delete_outline;
          lable = 'Delete';
          break;
        case .export:
          icon = Icons.import_export;
          lable = 'Export';
          break;
      }
      toReturn.add(
        PopupMenuItem(
          child: Row(children: [Icon(icon), SizedBox(width: 12), Text(lable)]),
          onTap: () => _onBingeAction(snapshot, action),
        ),
      );
    }

    return toReturn;
  }

  void _onVideoCardTap(BuildContext context, VideoModel video) {
    setState(() {
      _controller.setActiveVideoId(video.video.id);
    });
  }

  void _onPlayerEvent(BuildContext context, PlayerEventType eventType, {Object? data}) {
    switch (eventType) {
      case .onBack:
        Routes.popOrHome(context);
        break;
      case .onPrev:
        setState(() {
          _controller.setPrevVideo();
          updateQueryParams(context);
        });
        _scrollToActiveVideo();
        break;
      case .onNext:
        setState(() {
          _controller.setNextVideo();
          updateQueryParams(context);
        });
        _scrollToActiveVideo();
        break;
      case .onHeight:
        _playerHeight = data as double;
        break;
      case .onScrollEnd:
        _updateCollapseState();
        break;
      case .onListToggle:
        _onCollapsePressed();
        break;
      default:
        BingePage._logger.warning('unhandled eventType:$eventType');
    }
  }

  void updateQueryParams(BuildContext context) {
    final location = GoRouterState.of(context).name;
    if (location != Pages.binge.name) {
      return;
    }
    context.replaceNamed(
      Pages.binge.name,
      queryParameters: BingeController.updateParams(
        baseParams: widget.params,
        videoId: _controller.activeVideoId,
        heroId: _controller.heroId,
        heroImg: _controller.heroImg,
      ),
    );
  }

  void _scrollToActiveVideo() {
    const headerHeight = 0;
    const itemHeight = 98.0;
    final currPos = _controller.activeVideoPos!;
    _childScroll.animateTo(
      headerHeight + (currPos * itemHeight),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  void _onCollapsePressed() {
    _parentScroll.animateTo(
      _isCollapsed ? _playerHeight : 0,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
  }

  void _updateCollapseState() {
    setState(() {
      _isCollapsed = _parentScroll.offset == 0;
    });
  }

  void _onFilterPressed() {
    setState(() {
      if (_showRefine) {
        _controller.setFilter(BingeFilter.defaultValue);
        _controller.setSort(BingeSort.defaultValue);
      }
      _showRefine = !_showRefine;
    });
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

  Future<bool> _onRefineOpened(Type type) async {
    if (_isCollapsed) {
      _onCollapsePressed();
    }
    return true;
  }

  void _onActionAdd() {
    context.pushNamed(
      Pages.editBinge.name,
      queryParameters: EditBingePage.buildParams(widget.params),
    );
  }

  void _onBingeAction(AsyncSnapshot<BingeModel> snapshot, BingeActions action) {
    switch (action) {
      case .add:
      case .edit:
        _onActionAdd();
        break;
      case .moveTo:
        _onActionMoveTo();
        break;
      case .duplicate:
        _onActionDuplicate();
        break;
      case .delete:
        _onActionDelete();
        break;
      case .export:
        _onActionExport(snapshot);
        break;
    }
  }

  void _onActionMoveTo() async {
    final chosenCollection = await ChooseCollectionWidget.showChooseCollection(
      context,
      title: 'Move to collection',
    );
    if (chosenCollection == null) {
      return;
    }
    await _controller.executeBingeAction(.moveTo, collection: chosenCollection);
    final localContext = context;
    if (localContext.mounted) {
      Routes.popOrHome(localContext);
    }
  }

  void _onActionDuplicate() async {
    final chosenCollection = await ChooseCollectionWidget.showChooseCollection(
      context,
      title: 'Duplicate to collection',
    );
    if (chosenCollection == null) {
      return;
    }
    await _controller.executeBingeAction(.duplicate, collection: chosenCollection);
    final localContext = context;
    if (localContext.mounted) {
      Routes.popOrHome(localContext);
    }
  }

  void _onActionDelete() async {
    final confirm = await CustomDialog.show(
      context,
      'Delete series?',
      'Delete',
      Text('This will remove the series from your collection.'),
      cancelText: 'Cancel',
    );

    if (confirm) {
      await _controller.executeBingeAction(.delete);
      final localContext = context;
      if (localContext.mounted) {
        Routes.popOrHome(localContext);
      }
    }
  }

  void _onActionExport(AsyncSnapshot<BingeModel> snapshot) async {
    final model = snapshot.requireData;
    SeryPort.exportWithOSMenu(model);
  }
}

// Reuse the same delegate from before
class _BingeTitleDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _BingeTitleDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_BingeTitleDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
