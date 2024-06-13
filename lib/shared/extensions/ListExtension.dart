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

extension SharesListExtension on List<Share> {
  List<Share> ascendingSort() {
    return this
      ..sort((a, b) {
        if (a.amount == b.amount) {
          return a.from.name.compareTo(b.from.name);
        }

        return (a.amount - b.amount).toInt();
      });
  }

  List<Share> unionWithListOnPayee(List<Share> list) {
    return this.where((share) {
      return list.where((s) => s.to == share.to).firstOrNull != null;
    }).toList();
  }

  List<Share> whereFromTo(Splitee from, Splitee to) {
    return this
        .where(
          (share) => share.from == from && share.to == to,
        )
        .toList();
  }
}

extension SpliteeListExtension on List<Splitee> {
  List<Splitee> ascendingSortList() {
    return this..sort((a, b) => a.name.compareTo(b.name));
  }
}
