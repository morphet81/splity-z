part of 'split_bloc.dart';

sealed class SplitEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class DeleteSplit extends SplitEvent {
  DeleteSplit({required this.splitId});

  final int splitId;
}

final class DeleteSplitee extends SplitEvent {
  DeleteSplitee({required this.splitId, required this.splitee});

  final int splitId;
  final Splitee splitee;
}

final class UpdateSpliteeExpenseType extends SplitEvent {
  UpdateSpliteeExpenseType({required this.splitId, required this.splitee, required this.expenseType, required this.isSelected});

  final int splitId;
  final Splitee splitee;
  final ExpenseType expenseType;
  final bool isSelected;
}
