import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:splity_z/shared/models/models.dart';

part 'split_state.freezed.dart';
part 'split_state.g.dart';

@freezed
class SplitState with _$SplitState {
  const SplitState._();

  const factory SplitState({
    @Default(<Split>[]) List<Split> splits,
  }) = _SplitState;

  Split? findSplitWithId(int splitId) {
    return splits
        .where(
          (split) => split.id == splitId,
        )
        .firstOrNull;
  }

  static SplitState get initialState {
    return SplitState(
      splits: <Split>[],
    );
  }

  static SplitState get _devInitialState {
    final splitee1 = Splitee.withoutId(
      name: 'John Doe',
      expensesTypes: [...ExpenseType.values],
    );
    final splitee2 = Splitee.withoutId(
      name: 'Jane Doe',
      expensesTypes: [ExpenseType.food, ExpenseType.soft],
    );
    final splitee3 = Splitee.withoutId(
      name: 'Jack Downson',
      expensesTypes: [...ExpenseType.values],
    );
    final splitee4 = Splitee.withoutId(
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
        Split(
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
        Split(
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
        Split(
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
        Split(
          id: 4,
          name: 'Empty',
          splitees: <Splitee>[],
          expenses: <Expense>[],
        ),
      ],
    );
  }

  factory SplitState.fromJson(Map<String, Object?> json) =>
      _$SplitStateFromJson(json);
}
