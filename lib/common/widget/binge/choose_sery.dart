import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChooseSeryWidget extends StatefulWidget {
  final void Function(Sery value) onChoose;
  const ChooseSeryWidget({super.key, required this.onChoose});

  @override
  State<ChooseSeryWidget> createState() => _ChooseSeryWidgetState();

  static Future<Sery?> showChooseCollection(BuildContext context) async {
    Sery? toReturn;
    void onChoose(Sery value) {
      toReturn = value;
    }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (context) {
        return ChooseSeryWidget(onChoose: onChoose);
      },
    );
    return toReturn;
  }
}

class _ChooseSeryWidgetState extends State<ChooseSeryWidget> {
  late BingeDao _bingeDao;
  late List<Sery> _series;
  bool _isLoading = true;
  String? _inputValue;

  List<Sery> get _filteredCollection {
    if (_inputValue == null) {
      return _series;
    }
    return _series.where((c) => c.name.contains(_inputValue!)).toList();
  }

  @override
  void initState() {
    super.initState();
    _bingeDao = BingeDao(Database());
    _bingeDao.getSeries(isSystem: false).then((value) {
      setState(() {
        _series = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return CircularProgressIndicator();
    }
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scroll) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Choose series',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 8),

            Expanded(
              child: _filteredCollection.isEmpty
                  ? _buildListEmpty()
                  : _buildList(scroll),
            ),
          ],
        );
      },
    );
  }

  ListView _buildList(ScrollController scroll) {
    return ListView.builder(
      controller: scroll,
      itemCount: _filteredCollection.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_filteredCollection[index].name),
          onTap: () {
            widget.onChoose(_filteredCollection[index]);
            context.pop();
          },
        );
      },
    );
  }

  Widget _buildListEmpty() {
    return Center(
      child: const Text('No series found for the given search value'),
    );
  }
}
