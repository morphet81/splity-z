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
    List<Share> shares = _getRawShares();

    for (int i = 0; i < splitees.length; i++) {
      for (int j = i + 1; j < splitees.length; j++) {
        final Splitee splitee1 = splitees[i];
        final Splitee splitee2 = splitees[j];

        List<(Splitee, double)> debts = [
          (splitee1, 0.0),
          (splitee2, 0.0),
        ];

        shares.where(_isShareBetweenSplitees(splitee1, splitee2)).forEach(_computeDebtsBetweenSplitees(debts));

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

    _reduceTransactions(finalShares);

    finalShares.forEach((share) => debugPrint(share.toString()));

    return finalShares;
  }

  List<Share> _getRawShares() {
    List<Share> shares = [];

    expenses.forEach((expense) {
      expense.paidFor.where(_spliteeIsNotExpensePayer(expense)).forEach(_addOrUpdateSpliteeShare(expense, shares));
    });

    return shares;
  }

  void _reduceTransactions(List<Share> finalShares) {
    splitees.forEach((splitee) {
      final spliteeShares = finalShares.where((share) => share.from == splitee).toList();

      spliteeShares.forEach((spliteeShareToPayee) {
        final payee = spliteeShareToPayee.to;

        splitees.where((otherSplitee) => otherSplitee != splitee && otherSplitee != payee).forEach((otherSplitee) {
          final otherSpliteeShareWithSplitee = _shareBetweenSpliteesInList(splitee, otherSplitee, finalShares);
          final otherSpliteeShareToPayee = _shareFromSpliteeToPayeeInList(otherSplitee, payee, finalShares);

          if (otherSpliteeShareToPayee != null && otherSpliteeShareWithSplitee != null) {
            if (otherSpliteeShareWithSplitee.from == splitee && otherSpliteeShareToPayee.amount <= spliteeShareToPayee.amount) {
              _updateShareAmountInList(otherSpliteeShareWithSplitee, otherSpliteeShareWithSplitee.amount - otherSpliteeShareToPayee.amount, finalShares);
              _updateShareAmountInList(spliteeShareToPayee, spliteeShareToPayee.amount + otherSpliteeShareToPayee.amount, finalShares);
              finalShares.remove(otherSpliteeShareToPayee);
            } else if (otherSpliteeShareWithSplitee.from == otherSplitee && spliteeShareToPayee.amount <= otherSpliteeShareToPayee.amount) {
              _updateShareAmountInList(otherSpliteeShareWithSplitee, otherSpliteeShareToPayee.amount - spliteeShareToPayee.amount, finalShares);
              _updateShareAmountInList(otherSpliteeShareToPayee, otherSpliteeShareToPayee.amount + spliteeShareToPayee.amount, finalShares);
              finalShares.remove(spliteeShareToPayee);
            }
          }
        });
      });
    });
  }

  void Function(Splitee) _addOrUpdateSpliteeShare(Expense expense, List<Share> shares) {
    final amountPerPayee = expense.amount / expense.paidFor.length;

    return (splitee) {
      Share share = shares.firstWhere(
        _spliteeOwesPayer(splitee, expense),
        orElse: _spliteeToPayerShare(splitee, expense),
      );

      shares.remove(share);
      shares.add(share.coppyWith(amount: share.amount + amountPerPayee));
    };
  }

  void Function(Share) _computeDebtsBetweenSplitees(List<(Splitee, double)> debts) {
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

  bool Function(Splitee) _spliteeIsNotExpensePayer(Expense expense) {
    return (splitee) => splitee != expense.paidBy;
  }

  bool Function(Share) _spliteeOwesPayer(Splitee splitee, Expense expense) {
    return (share) => share.from == splitee && share.to == expense.paidBy;
  }

  Share Function() _spliteeToPayerShare(Splitee splitee, Expense expense) {
    return () => Share(from: splitee, to: expense.paidBy, amount: 0.0);
  }

  bool Function(Share) _isShareBetweenSplitees(Splitee splitee1, Splitee splitee2) {
    return (share) {
      return share.from == splitee1 && share.to == splitee2 || share.from == splitee2 && share.to == splitee1;
    };
  }

  Share? _shareBetweenSpliteesInList(Splitee splitee1, Splitee splitee2, List<Share> shares) {
    return shares.where(_isShareBetweenSplitees(splitee1, splitee2)).firstOrNull;
  }

  Share? _shareFromSpliteeToPayeeInList(Splitee splitee, Splitee payee, List<Share> shares) {
    return shares.where((share) => share.from == splitee && share.to == payee).firstOrNull;
  }

  void _updateShareAmountInList(Share share, double amount, List<Share> shares) {
    shares.remove(share);
    shares.add(share.coppyWith(amount: amount));
  }

  @override
  List<Object?> get props => [id, name, splitees, expenses];
}

/*
  Algorithm used to spread the shares and minimize transactions

  For each other splitee Jane owes money to, referred as the payee
    For each other splitee who is not jane or the payee
      Get all shares where this other splitee owes money to any one
      If this other splitee owes money to the payee
        If this other splitee has a share with Jane
          If Jane owes this other splitee
            If what this other splitee owes the payee is inferior or equal to what Jane owes this other splitee
              Decrease what Jane owes to the other splitee of the amount the other splitee owes to the payee
              Increase what Jane owes to the payee by the amount the other splitee owes to the payee
              Delete the share between this other splitee and the payee
          If this other splitee owes Jane
            If what Jane owes the payee is inferior or equal to what this other splitee owes Jane
              Decrease what this other splitee owes to Jane of the amount Jane owes to the payee
              Increase what this other splitee owes to the payee by the amount Jane owes to the payee
              Delete the share between Jane and the payee
  */
