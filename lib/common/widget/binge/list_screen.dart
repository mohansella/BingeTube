import 'package:bingetube/core/db/access/binge.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:flutter/material.dart';

class ListScreenWidget extends StatefulWidget {
  static final _logger = LogManager.getLogger('ListScreenWidget');

  final bool isSystem;
  const ListScreenWidget({super.key, required this.isSystem});

  @override
  State<ListScreenWidget> createState() => _ListScreenWidgetState();
}

class _ListScreenWidgetState extends State<ListScreenWidget> {
  late BingeDao _bingeDao;

  @override
  void initState() {
    super.initState();
    _bingeDao = BingeDao(Database());
  }

  @override
  void didUpdateWidget(covariant ListScreenWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bingeDao.streamCollectionModels(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final collections = snapshot.data!;
        if (collections.isEmpty) {
          return Center(
            child: Text(
              widget.isSystem
                  ? 'Work in progress'
                  : 'Collection is empty. Add more from search or import.',
            ),
          );
        }
        return Text('found ${collections.length} collections');
      },
    );
  }
}
