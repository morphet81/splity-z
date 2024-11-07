import 'package:splity_z/shared/models/models.dart';

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
      return list.where((s) => s.to.isSameAs(share.to)).firstOrNull != null;
    }).toList();
  }

  List<Share> whereFromTo(Splitee from, Splitee to) {
    return this
        .where(
          (share) => share.from.isSameAs(from) && share.to.isSameAs(to),
        )
        .toList();
  }
}
