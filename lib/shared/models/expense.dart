import 'package:equatable/equatable.dart';
import 'package:splity_z/shared/models/splitee.dart';

final class Expense extends Equatable {
  const Expense({required this.amount, required this.paidBy, required this.paidFor});

  final double amount;
  final Splitee paidBy;
  final List<Splitee> paidFor;

  @override
  List<Object?> get props => [amount, paidBy, paidFor];
}
