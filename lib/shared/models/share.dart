import 'package:equatable/equatable.dart';
import 'package:splity_z/shared/models/models.dart';

final class Share extends Equatable {
  const Share({
    required this.from,
    required this.to,
    required this.amount,
  });

  final Splitee from;
  final Splitee to;
  final double amount;

  Share coppyWith({Splitee? from, Splitee? to, double? amount}) {
    return Share(
      from: from ?? this.from,
      to: to ?? this.to,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object?> get props => [from, to, amount];

  @override
  String toString() {
    return '${from.name} owes ${to.name} the amount $amount';
  }

  int compateTo(Share share) {
    return this.from.name.compareTo(share.from.name);
  }

  bool isSimilarTo(Share share) {
    return this.from == share.from && this.to == share.to;
  }

  static int compareShares(Share a, Share b) {
    return a.compateTo(b);
  }

  static Share sharesListReducer(Share value, Share element) {
    return value.coppyWith(amount: value.amount + element.amount);
  }

  static List<Share> unionOnTo(List<Share> first, List<Share> second) {
    return first.where((share) {
      return second.where((s) => s.to == share.to).firstOrNull != null;
    }).toList();
  }

  static void ascendingSortList(List<Share> shares) {
    shares.sort((a, b) {
      if (a.amount == b.amount) {
        return a.from.name.compareTo(b.from.name);
      }

      return (a.amount - b.amount).toInt();
    });
  }
}
