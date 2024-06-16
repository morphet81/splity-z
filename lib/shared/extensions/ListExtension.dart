import 'package:splity_z/shared/models/models.dart';

extension Listextension on List {
  void removeAll(List items) {
    items.toList().forEach((item) => this.remove(item));
  }

  void replace(dynamic item, dynamic newItem) {
    final index = this.indexOf(item);
    this.removeAt(index);
    this.insert(index, newItem);
  }
}
