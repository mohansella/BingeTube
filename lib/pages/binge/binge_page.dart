import 'package:bingetube/common/widget/player/player_widget.dart';
import 'package:bingetube/pages/binge/binge_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BingePage extends ConsumerStatefulWidget {
  final Map<String, String> params;

  const BingePage(this.params, {super.key});

  @override
  ConsumerState createState() => _BingePageState();
}

class _BingePageState extends ConsumerState<BingePage> {
  late BingeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BingeController(widget.params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlayerWidget(
        controller: _controller,
        onBack: () => Navigator.pop(context),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _PlaylistTitleDelegate(
              minHeight: 60.0,
              maxHeight: 200.0,
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.grey,
                child: Text('Title'),
              ),
            ),
          ),
          SliverList.list(
            children: List.generate(100, (i) => Text('$i', textAlign: .center)),
          ),
        ],
      ),
    );
  }
}

// Reuse the same delegate from before
class _PlaylistTitleDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _PlaylistTitleDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_PlaylistTitleDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
