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

final class DeleteExpense extends SplitEvent {
  DeleteExpense({required this.splitId, required this.expense});

  final int splitId;
  final Expense expense;
}

final class UpdateExpenseExpenseType extends SplitEvent {
  UpdateExpenseExpenseType({required this.split, required this.expense, required this.expenseType, required this.isSelected});

  final Split split;
  final Expense expense;
  final ExpenseType expenseType;
  final bool isSelected;
}

final class UpdateExpenseSharingMode extends SplitEvent {
  UpdateExpenseSharingMode({required this.split, required this.expense, required this.isAutoSharingEnabled});

  final Split split;
  final Expense expense;
  final bool isAutoSharingEnabled;
}

final class UpdateExpensePaidForSplitee extends SplitEvent {
  UpdateExpensePaidForSplitee({required this.split, required this.expense, required this.splitee, required this.isSelected});

  final Split split;
  final Expense expense;
  final Splitee splitee;
  final bool isSelected;
}

final class UpdateExpensePaidBy extends SplitEvent {
  UpdateExpensePaidBy({required this.split, required this.expense, required this.splitee});

  final Split split;
  final Expense expense;
  final Splitee splitee;
}
