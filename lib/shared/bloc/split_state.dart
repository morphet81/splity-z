part of 'split_bloc.dart';

final class SplitState extends Equatable {
  const SplitState({
    this.splits = const <Split>[],
  });

  final List<Split> splits;

  Split? findSplitWithId(int splitId) {
    return splits
        .where(
          (split) => split.id == splitId,
        )
        .firstOrNull;
  }

  SplitState copyWith({List<Split>? splits}) {
    return SplitState(
      splits: splits ?? this.splits,
    );
  }

  @override
  List<Object?> get props => [splits, splits.length];

  static SplitState get initialState {
    final splitee1 = SpliteeImpl.withoutId(
      name: 'John Doe',
      expensesTypes: [...ExpenseType.values],
    );
    final splitee2 = SpliteeImpl.withoutId(
      name: 'Jane Doe',
      expensesTypes: [ExpenseType.food, ExpenseType.soft],
    );
    final splitee3 = SpliteeImpl.withoutId(
      name: 'Jack Downson',
      expensesTypes: [...ExpenseType.values],
    );
    final splitee4 = SpliteeImpl.withoutId(
      name: 'Andre Pourlov Droupinov Kasparov',
      expensesTypes: [
        ExpenseType.alcohol,
        ExpenseType.food,
        ExpenseType.taxi,
      ],
    );

    final allSplitees = [splitee1, splitee2, splitee3, splitee4];

    return SplitState(
      splits: <Split>[
        SplitImpl(
          id: 1,
          name: 'Diner at the end of the world',
          splitees: <Splitee>[
            splitee1,
            splitee2,
          ],
          expenses: <Expense>[
            Expense.withAutomaticSharing(
              name:
                  'Reprehenderit duis do sit labore adipisicing reprehenderit nostrud proident proident officia sint et consequat est.',
              amount: 99.99,
              paidBy: splitee1,
              expensesTypes: [ExpenseType.alcohol, ExpenseType.soft],
              allSplitees: [splitee1, splitee2],
            ),
            Expense.withPaidForList(
              name: 'Second expense',
              amount: 10.5,
              paidBy: splitee1,
              paidFor: [splitee1],
            ),
          ],
        ),
        SplitImpl(
          id: 2,
          name: 'Cinema',
          splitees: <Splitee>[
            splitee1,
            splitee2,
            splitee3,
          ],
          expenses: <Expense>[
            Expense.withPaidForList(
              name: 'First expense',
              amount: 23.4,
              paidBy: splitee3,
              paidFor: [splitee1, splitee2],
            ),
            Expense.withPaidForList(
              name: 'Second expense',
              amount: 10.5,
              paidBy: splitee3,
              paidFor: [splitee1, splitee3],
            ),
            Expense.withPaidForList(
              name: 'Third expense',
              amount: 10.5,
              paidBy: splitee2,
              paidFor: [splitee1, splitee2],
            ),
          ],
        ),
        SplitImpl(
          id: 3,
          name: 'Diner at the end of the world',
          splitees: <Splitee>[
            splitee1,
            splitee2,
            splitee3,
            splitee4,
          ],
          expenses: <Expense>[
            Expense.withAutomaticSharing(
              name: 'First expense',
              amount: 56,
              paidBy: splitee1,
              expensesTypes: [ExpenseType.alcohol, ExpenseType.soft],
              allSplitees: allSplitees,
            ), // 14 per pax
            Expense.withPaidForList(
              name: 'Second expense',
              amount: 37,
              paidBy: splitee1,
              paidFor: [splitee2, splitee3],
            ), // 18.5 per pax
            Expense.withPaidForList(
              name: 'Third expense',
              amount: 15,
              paidBy: splitee4,
              paidFor: [splitee1, splitee2, splitee3],
            ), // 5 per pax
            Expense.withPaidForList(
              name: 'Fourth expense',
              amount: 18,
              paidBy: splitee4,
              paidFor: [splitee4, splitee2],
            ), // 9 per pax
            Expense.withPaidForList(
              name: 'Fifth expense',
              amount: 4,
              paidBy: splitee4,
              paidFor: [splitee3],
            ),
          ],
        ),
        SplitImpl(
          id: 4,
          name: 'Empty',
          splitees: <Splitee>[],
          expenses: <Expense>[],
        ),
      ],
    );
  }
}
