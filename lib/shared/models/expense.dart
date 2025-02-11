import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:splity_z/shared/models/converters/unique_key_converter.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

@freezed
class Expense with _$Expense {
  const Expense._();

  const factory Expense({
    @UniqueKeyConverter() required UniqueKey id,
    required String name,
    required double amount,
    required Splitee paidBy,
    required List<Splitee> paidFor,
    required List<ExpenseType> expensesTypes,
    required bool automaticSharing,
    List<Splitee>? manualPaidFor,
  }) = _Expense;

  factory Expense.withPaidForList({
    required String name,
    required double amount,
    required Splitee paidBy,
    required List<Splitee> paidFor,
  }) {
    return Expense(
      id: UniqueKey(),
      name: name,
      amount: amount,
      paidBy: paidBy,
      paidFor: paidFor,
      expensesTypes: [],
      automaticSharing: false,
    );
  }

  factory Expense.withAutomaticSharing({
    required String name,
    required double amount,
    required Splitee paidBy,
    required List<ExpenseType> expensesTypes,
    required List<Splitee> allSplitees,
  }) {
    final paidFor = allSplitees.containingExpenseTypes(expensesTypes);

    return Expense(
      id: UniqueKey(),
      name: name,
      amount: amount,
      paidBy: paidBy,
      paidFor: paidFor,
      expensesTypes: expensesTypes,
      automaticSharing: true,
    );
  }

  factory Expense.blank() => Expense(
        id: UniqueKey(),
        name: '',
        amount: 0,
        paidBy: Splitee.blank(),
        paidFor: [],
        expensesTypes: [],
        automaticSharing: false,
      );

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
      paidFor: manualPaidFor?.toList() ?? [],
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

  factory Expense.fromJson(Map<String, Object?> json) =>
      _$ExpenseFromJson(json);
}
