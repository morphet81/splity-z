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
}
