part of 'split_bloc.dart';

final class SplitState extends Equatable {
  const SplitState({
    this.splits = const <SplitImpl>[],
  });

  final List<SplitImpl> splits;

  SplitImpl? findSplitWithId(int splitId) {
    return splits
        .where(
          (element) => element.id == splitId,
        )
        .firstOrNull;
  }

  SplitState copyWith({List<SplitImpl>? splits}) {
    return SplitState(
      splits: splits ?? this.splits,
    );
  }

  @override
  List<Object?> get props => [splits];

  static SplitState get initialState {
    const splitee1 = Splitee(name: 'John Doe');
    const splitee2 = Splitee(name: 'Jane Doe');
    const splitee3 = Splitee(name: 'Mister X');

    return SplitState(splits: <SplitImpl>[
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
      )
    ]);
  }
}
