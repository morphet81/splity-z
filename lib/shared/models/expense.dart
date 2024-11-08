import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

final class Expense extends Equatable {
  const Expense({
    required this.id,
    required this.name,
    required this.amount,
    required this.paidBy,
    required this.paidFor,
    required this.expensesTypes,
    required this.automaticSharing,
    this.manualPaidFor,
  });

  Expense.withPaidForList({
    required this.name,
    required this.amount,
    required this.paidBy,
    required this.paidFor,
  })  : id = UniqueKey(),
        expensesTypes = [],
        automaticSharing = false,
        manualPaidFor = null;

  Expense.withAutomaticSharing({
    required this.name,
    required this.amount,
    required this.paidBy,
    required this.expensesTypes,
    required List<Splitee> allSplitees,
  })  : id = UniqueKey(),
        paidFor = allSplitees
            .where(
              (splitee) => expensesTypes.containsAny(splitee.expensesTypes),
            )
            .toList(),
        automaticSharing = true,
        manualPaidFor = null;

  Expense.blank()
      : this.withAutomaticSharing(
          name: '',
          amount: 0,
          paidBy: SpliteeImpl.blank(),
          expensesTypes: [],
          allSplitees: [],
        );

  final UniqueKey id;
  final String name;
  final double amount;
  final Splitee paidBy;
  final List<Splitee> paidFor;
  final List<Splitee>? manualPaidFor;
  final List<ExpenseType> expensesTypes;
  final bool automaticSharing;

  Expense copyWith({
    UniqueKey? id,
    String? name,
    double? amount,
    Splitee? paidBy,
    List<Splitee>? paidFor,
    List<Splitee>? manualPaidFor,
    List<ExpenseType>? expensesTypes,
    List<ExpenseType>? manualExpensesTypes,
    bool? automaticSharing,
  }) {
    return Expense(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      paidBy: paidBy ?? this.paidBy,
      paidFor: paidFor ?? this.paidFor,
      manualPaidFor: manualPaidFor ?? this.manualPaidFor,
      expensesTypes: expensesTypes ?? this.expensesTypes,
      automaticSharing: automaticSharing ?? this.automaticSharing,
    );
  }

  Expense copyWithAutomaticSharing(List<Splitee> allSplitees) {
    final newPaidFor = allSplitees.containingExpenseTypes(expensesTypes);

    return copyWith(
      manualPaidFor: paidFor.toList(),
      paidFor: newPaidFor,
      automaticSharing: true,
    );
  }

  Expense copyWithoutAutomaticSharing() {
    return copyWith(
      paidFor: manualPaidFor?.toList(),
      manualExpensesTypes: expensesTypes.toList(),
      automaticSharing: false,
    );
  }

  Expense copyReplacingSplitee(Splitee oldSplitee, Splitee newSplitee) {
    return copyWith(
      paidFor: paidFor.toList()..replace(oldSplitee, newSplitee),
    );
  }

  Expense copyAddingSplitee(Splitee splitee) {
    return copyWith(
      paidFor: paidFor.toList()..add(splitee),
    );
  }

  Expense copyRemovingSplitee(Splitee splitee) {
    return copyWith(
      paidFor: paidFor.toList()..remove(splitee),
    );
  }

  bool isBlank() {
    return name.isEmpty;
  }

  bool isPaidBy(Splitee splitee) {
    return paidBy.id == splitee.id;
  }

  Splitee? paidForSpliteeMatching(Splitee splitee) {
    return paidFor.where((s) => s.id == splitee.id).firstOrNull;
  }

  bool isPaidFor(Splitee splitee) {
    return paidForSpliteeMatching(splitee) != null;
  }

  bool sharesExpenseTypesWithSplitee(Splitee splitee) {
    return expensesTypes.containsAny(splitee.expensesTypes);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        amount,
        paidBy,
        paidFor,
        manualPaidFor,
        expensesTypes,
        automaticSharing,
      ];
}
