import 'package:equatable/equatable.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

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

  Split copyWith({int? id, String? name, List<Splitee>? splitees, List<Expense>? expenses});
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
    List<Share> finalShares = _getRawShares();

    finalShares = _reduceTransactions(finalShares);

    finalShares.sort(Share.compareShares);

    finalShares = _superReduceTransactions(finalShares);

    return finalShares;
  }

  List<Share> _getRawShares() {
    List<Share> shares = [];

    expenses.forEach((expense) {
      expense.paidFor
          .where(
            _spliteeIsNotTheExpensePayer(expense),
          )
          .forEach(
            _addOrUpdateSpliteeShare(expense, shares),
          );
    });

    return shares;
  }

  List<Share> _reduceTransactions(List<Share> finalShares) {
    Map<Splitee, List<Share>> spliteesShares = Map();
    List<Share> updatedFinalShares = [];

    splitees.forEach((splitee) {
      spliteesShares.putIfAbsent(splitee, () => finalShares.where((share) => share.from == splitee).toList());
    });

    spliteesShares.removeWhere((splitee, shares) => shares.length == 0);

    for (int i = 0; i < splitees.length; i++) {
      for (int j = i + 1; j < splitees.length; j++) {
        final firstSplitee = splitees[i];
        final secondSplitee = splitees[j];

        final firstSpliteeSharesToSecondSplitee = finalShares.whereFromTo(firstSplitee, secondSplitee);
        final secondSpliteeSharesToFirstSplitee = finalShares.whereFromTo(secondSplitee, firstSplitee);

        final double firstSpliteeOwesSecondAmount = firstSpliteeSharesToSecondSplitee.length > 0 ? firstSpliteeSharesToSecondSplitee.reduce(Share.sharesListReducer).amount : 0;
        final double secondSpliteeOwesFirstAmount = secondSpliteeSharesToFirstSplitee.length > 0 ? secondSpliteeSharesToFirstSplitee.reduce(Share.sharesListReducer).amount : 0;

        final finalBalance = firstSpliteeOwesSecondAmount - secondSpliteeOwesFirstAmount;

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
    Map<Splitee, List<Share>> spliteesShares = Map();
    List<Share> updatedFinalShares = List.from(finalShares);

    splitees.forEach((splitee) {
      spliteesShares.putIfAbsent(splitee, () => updatedFinalShares.where((share) => share.from == splitee).toList());
    });

    for (int i = 0; i < splitees.length; i++) {
      for (int j = i + 1; j < splitees.length; j++) {
        final List<Splitee> comparedSplitees = [
          splitees[i],
          splitees[j],
        ].ascendingSortList();

        final firstSharesItems = spliteesShares[comparedSplitees[0]];
        final secondSharesItems = spliteesShares[comparedSplitees[1]];

        final firstShares = firstSharesItems!.unionWithListOnPayee(secondSharesItems!);
        final secondShares = secondSharesItems.unionWithListOnPayee(firstSharesItems);

        if (firstShares.length == 2 && secondShares.length == 2) {
          firstShares.ascendingSort();
          secondShares.ascendingSort();

          if (_sharesHaveSameAmountAndDifferentPayees(firstShares.first, secondShares.first)) {
            updatedFinalShares.removeAll([
              ...firstShares,
              ...secondShares,
            ]);

            updatedFinalShares.add(firstShares.last.coppyWith(amount: firstShares.last.amount + firstShares.first.amount));
            updatedFinalShares.add(secondShares.last.coppyWith(amount: secondShares.last.amount + secondShares.first.amount));
          } else {
            final shareThatsGettingCoveredFor = firstShares.first.amount <= secondShares.first.amount ? firstShares.first : secondShares.first;

            final isCoveredShareForFirstSplitee = shareThatsGettingCoveredFor == firstShares.first;

            final shareThatWillCover = isCoveredShareForFirstSplitee ? secondShares.first : firstShares.first;
            final shareThatWillDecreaseAmount = isCoveredShareForFirstSplitee ? secondShares.last : firstShares.last;
            final shareThatWillIncreaseAmount = isCoveredShareForFirstSplitee ? firstShares.last : secondShares.last;

            updatedFinalShares.removeAll([
              ...firstShares,
              ...secondShares,
            ]);

            updatedFinalShares.add(shareThatWillCover.coppyWith(amount: shareThatWillCover.amount + shareThatsGettingCoveredFor.amount));
            updatedFinalShares.add(shareThatWillDecreaseAmount.coppyWith(amount: shareThatWillDecreaseAmount.amount - shareThatsGettingCoveredFor.amount));
            updatedFinalShares.add(shareThatWillIncreaseAmount.coppyWith(amount: shareThatWillIncreaseAmount.amount + shareThatsGettingCoveredFor.amount));
          }
        }
      }
    }

    return updatedFinalShares;
  }

  void Function(Splitee) _addOrUpdateSpliteeShare(Expense expense, List<Share> shares) {
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

  bool _sharesHaveSameAmountAndDifferentPayees(Share firstShare, Share secondShare) {
    return firstShare.amount == secondShare.amount && firstShare.to != secondShare.to;
  }

  @override
  List<Object?> get props => [id, name, splitees, expenses];

  @override
  Split copyWith({int? id, String? name, List<Splitee>? splitees, List<Expense>? expenses}) {
    return SplitImpl(
      id: id ?? this.id,
      name: name ?? this.name,
      splitees: splitees ?? this.splitees,
      expenses: expenses ?? this.expenses,
    );
  }
}
