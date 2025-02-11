import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/extensions/extensions.dart';
import 'package:uuid/uuid.dart';

part 'split.freezed.dart';
part 'split.g.dart';

@freezed
abstract class Split with _$Split {
  const Split._();

  const factory Split({
    required String id,
    required String name,
    required List<Splitee> splitees,
    required List<Expense> expenses,
  }) = _Split;

  factory Split.withName(String name) => Split(
        id: Uuid().v4(),
        name: name,
        splitees: [],
        expenses: [],
      );

  factory Split.fromJson(Map<String, Object?> json) => _$SplitFromJson(json);

  List<Share> getShares() {
    List<Share> finalShares = _getRawShares();

    finalShares = _reduceTransactions(finalShares);

    finalShares.sort(Share.compareShares);

    finalShares = _superReduceTransactions(finalShares);

    return finalShares;
  }

  List<Share> _getRawShares() {
    List<Share> shares = [];

    for (var expense in expenses) {
      expense.paidFor
          .where(
            _spliteeIsNotTheExpensePayer(
              expense,
            ),
          )
          .forEach(
            _addOrUpdateSpliteeShare(
              expense,
              shares,
            ),
          );
    }

    return shares;
  }

  List<Share> _reduceTransactions(List<Share> finalShares) {
    Map<Splitee, List<Share>> spliteesShares = {};
    List<Share> updatedFinalShares = [];

    for (var splitee in splitees) {
      spliteesShares.putIfAbsent(
        splitee,
        () => finalShares
            .where(
              (share) => share.from.isSameAs(splitee),
            )
            .toList(),
      );
    }

    spliteesShares.removeWhere((splitee, shares) => shares.isEmpty);

    for (int i = 0; i < splitees.length; i++) {
      for (int j = i + 1; j < splitees.length; j++) {
        final firstSplitee = splitees[i];
        final secondSplitee = splitees[j];

        final firstSpliteeSharesToSecondSplitee = finalShares.whereFromTo(
          firstSplitee,
          secondSplitee,
        );

        final secondSpliteeSharesToFirstSplitee = finalShares.whereFromTo(
          secondSplitee,
          firstSplitee,
        );

        final double firstSpliteeOwesSecondAmount =
            firstSpliteeSharesToSecondSplitee.isNotEmpty
                ? firstSpliteeSharesToSecondSplitee
                    .reduce(Share.sharesListReducer)
                    .amount
                : 0;

        final double secondSpliteeOwesFirstAmount =
            secondSpliteeSharesToFirstSplitee.isNotEmpty
                ? secondSpliteeSharesToFirstSplitee
                    .reduce(Share.sharesListReducer)
                    .amount
                : 0;

        final finalBalance =
            firstSpliteeOwesSecondAmount - secondSpliteeOwesFirstAmount;

        if (finalBalance == 0) {
          continue;
        }

        final payer = finalBalance > 0 ? firstSplitee : secondSplitee;
        final payee = finalBalance > 0 ? secondSplitee : firstSplitee;

        updatedFinalShares.add(
          Share(from: payer, to: payee, amount: finalBalance.abs()),
        );
      }
    }

    return updatedFinalShares;
  }

  List<Share> _superReduceTransactions(List<Share> finalShares) {
    Map<Splitee, List<Share>> spliteesShares = {};
    List<Share> updatedFinalShares = List.from(finalShares);

    for (var splitee in splitees) {
      spliteesShares.putIfAbsent(
        splitee,
        () =>
            updatedFinalShares.where((share) => share.from == splitee).toList(),
      );
    }

    for (int i = 0; i < splitees.length; i++) {
      for (int j = i + 1; j < splitees.length; j++) {
        final List<Splitee> comparedSplitees = [
          splitees[i],
          splitees[j],
        ].ascendingSortList();

        final firstSharesItems = spliteesShares[comparedSplitees[0]];
        final secondSharesItems = spliteesShares[comparedSplitees[1]];

        final firstShares =
            firstSharesItems!.unionWithListOnPayee(secondSharesItems!);
        final secondShares =
            secondSharesItems.unionWithListOnPayee(firstSharesItems);

        if (firstShares.length == 2 && secondShares.length == 2) {
          firstShares.ascendingSort();
          secondShares.ascendingSort();

          if (_sharesHaveSameAmountAndDifferentPayees(
            firstShares.first,
            secondShares.first,
          )) {
            updatedFinalShares.removeAll([
              ...firstShares,
              ...secondShares,
            ]);

            updatedFinalShares.add(
              firstShares.last.copyWith(
                amount: firstShares.last.amount + firstShares.first.amount,
              ),
            );
            updatedFinalShares.add(
              secondShares.last.copyWith(
                amount: secondShares.last.amount + secondShares.first.amount,
              ),
            );
          } else {
            final shareThatsGettingCoveredFor =
                firstShares.first.amount <= secondShares.first.amount
                    ? firstShares.first
                    : secondShares.first;

            final isCoveredShareForFirstSplitee =
                shareThatsGettingCoveredFor == firstShares.first;

            final shareThatWillCover = isCoveredShareForFirstSplitee
                ? secondShares.first
                : firstShares.first;
            final shareThatWillDecreaseAmount = isCoveredShareForFirstSplitee
                ? secondShares.last
                : firstShares.last;
            final shareThatWillIncreaseAmount = isCoveredShareForFirstSplitee
                ? firstShares.last
                : secondShares.last;

            updatedFinalShares.removeAll([
              ...firstShares,
              ...secondShares,
            ]);

            updatedFinalShares.add(
              shareThatWillCover.copyWith(
                amount: shareThatWillCover.amount +
                    shareThatsGettingCoveredFor.amount,
              ),
            );
            updatedFinalShares.add(
              shareThatWillDecreaseAmount.copyWith(
                amount: shareThatWillDecreaseAmount.amount -
                    shareThatsGettingCoveredFor.amount,
              ),
            );
            updatedFinalShares.add(
              shareThatWillIncreaseAmount.copyWith(
                amount: shareThatWillIncreaseAmount.amount +
                    shareThatsGettingCoveredFor.amount,
              ),
            );
          }
        }
      }
    }

    return updatedFinalShares;
  }

  void Function(Splitee) _addOrUpdateSpliteeShare(
    Expense expense,
    List<Share> shares,
  ) {
    final amountPerPayee = expense.amount / expense.paidFor.length;

    return (splitee) {
      shares.add(
        Share(
          from: splitee,
          to: expense.paidBy,
          amount: amountPerPayee,
        ),
      );
    };
  }

  bool Function(Splitee) _spliteeIsNotTheExpensePayer(Expense expense) {
    return (splitee) => splitee != expense.paidBy;
  }

  bool _sharesHaveSameAmountAndDifferentPayees(
    Share firstShare,
    Share secondShare,
  ) {
    return firstShare.amount == secondShare.amount &&
        firstShare.to != secondShare.to;
  }
}
