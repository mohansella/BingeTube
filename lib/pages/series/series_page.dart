import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SeriesPage extends ConsumerStatefulWidget {
  final String slug;
  const SeriesPage(this.slug, {super.key});

  @override
  ConsumerState<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends ConsumerState<SeriesPage> {
  @override
  Widget build(BuildContext context) {
    return Text('loading: ${widget.slug}');
  }
}
