import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

final class Expense extends Equatable {
  Expense({required this.id, required this.name, required this.amount, required this.paidBy, required this.paidFor, required this.expensesTypes, required this.automaticSharing});

  Expense.withPaidForList({required this.name, required this.amount, required this.paidBy, required this.paidFor})
      : id = UniqueKey(),
        expensesTypes = [],
        automaticSharing = false;

  Expense.withAutomaticSharing({required this.name, required this.amount, required this.paidBy, required this.expensesTypes, required List<Splitee> allSplitees})
      : id = UniqueKey(),
        paidFor = allSplitees.where((splitee) => expensesTypes.containsAny(splitee.expensesTypes)).toList(),
        automaticSharing = true;

  final UniqueKey id;
  final String name;
  final double amount;
  final Splitee paidBy;
  final List<Splitee> paidFor;
  final List<ExpenseType> expensesTypes;
  final bool automaticSharing;

  Expense copyWith({UniqueKey? id, String? name, double? amount, Splitee? paidBy, List<Splitee>? paidFor, List<ExpenseType>? expensesTypes, bool? automaticSharing}) {
    return Expense(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      paidBy: paidBy ?? this.paidBy,
      paidFor: paidFor ?? this.paidFor,
      expensesTypes: expensesTypes ?? this.expensesTypes,
      automaticSharing: automaticSharing ?? this.automaticSharing,
    );
  }

  Expense copyWithAutomaticSharing(List<Splitee> allSplitees) {
    List<Splitee> paidFor = allSplitees
        .where(
          (splitee) => this.expensesTypes.containsAny(splitee.expensesTypes),
        )
        .toList();

    return this.copyWith(paidFor: paidFor, automaticSharing: true);
  }

  @override
  List<Object?> get props => [id, name, amount, paidBy, paidFor, expensesTypes, automaticSharing];
}
