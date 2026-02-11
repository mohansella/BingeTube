import 'package:bingetube/core/db/database.dart';
import 'package:bingetube/core/db/models/sery_model.dart';

class CollectionModel {
  final Collection collection;
  final List<SeryModel> series;

  CollectionModel({required this.collection, required this.series});
}
