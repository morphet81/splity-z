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
    return from.name.compareTo(share.from.name);
  }

  bool isSimilarTo(Share share) {
    return from == share.from && to == share.to;
  }

  static int compareShares(Share a, Share b) {
    return a.compateTo(b);
  }

  static Share sharesListReducer(Share value, Share element) {
    return value.coppyWith(amount: value.amount + element.amount);
  }
}
