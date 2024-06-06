part of 'split_bloc.dart';

final class SplitState extends Equatable {
  const SplitState({
    this.splits = const <Split>[],
  });

  final List<Split> splits;

  Split? findSplitWithId(int splitId) {
    return splits
        .where(
          (element) => element.id == splitId,
        )
        .firstOrNull;
  }

  SplitState copyWith({List<Split>? splits, bool? myTest}) {
    return SplitState(
      splits: splits ?? this.splits,
    );
  }

  @override
  List<Object?> get props => [splits];

  static SplitState get initialState {
    const splitee1 = Splitee(name: 'John Doe');
    const splitee2 = Splitee(name: 'Jane Doe');
    const splitee3 = Splitee(name: 'Jack Downson');
    const splitee4 = Splitee(name: 'Andre Pourlov Droupinov Kasparov');

    return SplitState(splits: <Split>[
      SplitImpl(
        id: 1,
        name: 'Diner at the end of the world',
        splitees: <Splitee>[
          splitee1,
          splitee2,
        ],
        expenses: <Expense>[
          Expense(
            amount: 23.4,
            paidBy: splitee1,
            paidFor: [splitee1, splitee2],
          ),
          Expense(
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
          Expense(
            amount: 23.4,
            paidBy: splitee3,
            paidFor: [splitee1, splitee2],
          ),
          Expense(
            amount: 10.5,
            paidBy: splitee3,
            paidFor: [splitee1, splitee3],
          ),
          Expense(
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
          Expense(
            amount: 56,
            paidBy: splitee1,
            paidFor: [splitee1, splitee2, splitee3, splitee4],
          ), // 14 per pax
          Expense(
            amount: 37,
            paidBy: splitee1,
            paidFor: [splitee2, splitee3],
          ), // 18.5 per pax
          Expense(
            amount: 15,
            paidBy: splitee4,
            paidFor: [splitee1, splitee2, splitee3],
          ), // 5 per pax
          Expense(
            amount: 18,
            paidBy: splitee4,
            paidFor: [splitee4, splitee2],
          ), // 9 per pax
          Expense(
            amount: 4,
            paidBy: splitee4,
            paidFor: [splitee3],
          ),
        ],
      )
    ]);
  }
}
