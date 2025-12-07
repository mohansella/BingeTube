import 'package:drift/drift.dart';

mixin TableTimedMixin on Table {
  late final createdAt = dateTime().withDefault(currentDateAndTime)();
  late final updatedAt = dateTime().withDefault(currentDateAndTime)();
}
