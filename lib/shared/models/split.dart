import 'package:flutter/material.dart';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:splity_z/shared/models/models.dart';

abstract class Split extends Equatable {
  Split({
    required this.id,
    required this.name,
    required this.splitees,
    required this.expenses,
  });

  final int id;
  final String name;
  final List<Splitee> splitees;
  final List<Expense> expenses;

  List<Share> getShares();
}

final class SplitImpl extends Split {
  SplitImpl({
    required int id,
    required String name,
    required List<Splitee> splitees,
    required List<Expense> expenses,
  }) : super(id: id, name: name, splitees: splitees, expenses: expenses);

  @override
  List<Share> getShares() {
    List<Share> finalShares = [];
    List<Share> shares = getRawShares();

    for (int i = 0; i < splitees.length; i++) {
      for (int j = i + 1; j < splitees.length; j++) {
        final Splitee splitee1 = splitees[i];
        final Splitee splitee2 = splitees[j];

        List<(Splitee, double)> debts = [
          (splitee1, 0.0),
          (splitee2, 0.0),
        ];

        shares.where(isShareBetweenSplitees(splitee1, splitee2)).forEach(computeDebtsBetweenSplitees(debts));

        final debtsShares = debts.map((debt) {
          if (debt.$2 > 0) {
            return Share(
              from: debt.$1,
              to: debt.$1 == splitee1 ? splitee2 : splitee1,
              amount: debt.$2,
            );
          }
        }).nonNulls;

        finalShares.addAll(debtsShares);
      }
    }

    /*
      For each person Jane owes money to, referred as the bank
        For each person who is not jane or the bank
          Get all shares where this person owes money to any one
          If this person owes money to the bank
            If this person has a share with Jane
              If Jane owes this person
                If what this person owes the bank is inferior or equal to what Jane owes this person
                  Decrease what Jane owes to the person of the amount the person owes to the bank
                  Increase what Jane owes to the bank by the amount the person owes to the bank
                  Delete the share between this person and the bank
              If this person owes Jane
                If what Jane owes the bank is inferior or equal to what this person owes Jane
                  Decrease what this person owes to Jane of the amount Jane owes to the bank
                  Increase what this person owes to the bank by the amount Jane owes to the bank
                  Delete the share between Jane and the bank
      */

    splitees.forEach((splitee) {
      final spliteeShares = finalShares.where((share) => share.from == splitee).toList();

      spliteeShares.forEach((spliteeShareToPayee) {
        final payee = spliteeShareToPayee.to;

        splitees.where((otherSplitee) => otherSplitee != splitee && otherSplitee != payee).forEach((otherSplitee) {
          final otherSpliteeShareWithSplitee = finalShares.where(isShareBetweenSplitees(splitee, otherSplitee)).firstOrNull;
          final otherSpliteeShareToPayee = finalShares.where((share) => share.from == otherSplitee && share.to == payee).firstOrNull;

          if (otherSpliteeShareToPayee != null && otherSpliteeShareWithSplitee != null) {
            if (otherSpliteeShareWithSplitee.from == splitee && otherSpliteeShareToPayee.amount <= spliteeShareToPayee.amount) {
              // Decrease what Jane owes to the person of the amount the person owes to the bank
              finalShares.remove(otherSpliteeShareWithSplitee);
              finalShares.add(otherSpliteeShareWithSplitee.coppyWith(amount: otherSpliteeShareWithSplitee.amount - otherSpliteeShareToPayee.amount));
              // Increase what Jane owes to the bank by the amount the person owes to the bank
              finalShares.remove(spliteeShareToPayee);
              finalShares.add(spliteeShareToPayee.coppyWith(amount: spliteeShareToPayee.amount + otherSpliteeShareToPayee.amount));
              // Delete the share between this person and the bank
              finalShares.remove(otherSpliteeShareToPayee);
            } else if (otherSpliteeShareWithSplitee.from == otherSplitee && spliteeShareToPayee.amount <= otherSpliteeShareToPayee.amount) {
              // Decrease what this person owes to Jane of the amount Jane owes to the bank
              finalShares.remove(otherSpliteeShareWithSplitee);
              finalShares.add(otherSpliteeShareWithSplitee.coppyWith(amount: otherSpliteeShareToPayee.amount - spliteeShareToPayee.amount));
              // Increase what this person owes to the bank by the amount Jane owes to the bank
              finalShares.remove(otherSpliteeShareToPayee);
              finalShares.add(otherSpliteeShareToPayee.coppyWith(amount: otherSpliteeShareToPayee.amount + spliteeShareToPayee.amount));
              // Delete the share between Jane and the bank
              finalShares.remove(spliteeShareToPayee);
            }
          }
        });
      });
    });

    finalShares.forEach((share) => debugPrint(share.toString()));

    return finalShares;
  }

  List<Share> getRawShares() {
    List<Share> shares = [];

    expenses.forEach((expense) {
      expense.paidFor.where(spliteeIsNotExpensePayer(expense)).forEach(addOrUpdateSpliteeShare(expense, shares));
    });

    return shares;
  }

  void Function(Splitee) addOrUpdateSpliteeShare(Expense expense, List<Share> shares) {
    final amountPerPayee = expense.amount / expense.paidFor.length;

    return (splitee) {
      Share share = shares.firstWhere(
        spliteeOwesPayer(splitee, expense),
        orElse: spliteeToPayerShare(splitee, expense),
      );

      shares.remove(share);
      shares.add(share.coppyWith(amount: share.amount + amountPerPayee));
    };
  }

  void Function(Share) computeDebtsBetweenSplitees(List<(Splitee, double)> debts) {
    if (debts.length != 2) {
      throw Exception('debts must contain 2 items only');
    }

    return (share) {
      final index = share.from == debts[0].$1 ? 0 : 1;
      debts[index] = (debts[index].$1, debts[index].$2 + share.amount);

      final double splitee1Debt = max(debts[0].$2 - debts[1].$2, 0);
      final double splitee2Debt = max(debts[1].$2 - debts[0].$2, 0);

      debts[0] = (debts[0].$1, splitee1Debt);
      debts[1] = (debts[1].$1, splitee2Debt);
    };
  }

  bool Function(Splitee) spliteeIsNotExpensePayer(Expense expense) {
    return (splitee) => splitee != expense.paidBy;
  }

  bool Function(Share) spliteeOwesPayer(Splitee splitee, Expense expense) {
    return (share) => share.from == splitee && share.to == expense.paidBy;
  }

  Share Function() spliteeToPayerShare(Splitee splitee, Expense expense) {
    return () => Share(from: splitee, to: expense.paidBy, amount: 0.0);
  }

  bool Function(Share) isShareBetweenSplitees(Splitee splitee1, Splitee splitee2) {
    return (share) {
      return share.from == splitee1 && share.to == splitee2 || share.from == splitee2 && share.to == splitee1;
    };
  }

  @override
  List<Object?> get props => [id, name, splitees, expenses];
}
