part of 'split_bloc.dart';

sealed class SplitEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class DeleteSplit extends SplitEvent {
  DeleteSplit({required this.split});

  final Split split;
}

final class DeleteSplitee extends SplitEvent {
  DeleteSplitee({required this.split, required this.splitee});

  final Split split;
  final Splitee splitee;
}

final class UpdateSpliteeName extends SplitEvent {
  UpdateSpliteeName({required this.split, required this.splitee, required this.name});

  final Split split;
  final Splitee splitee;
  final String name;
}

final class UpdateSpliteeExpenseType extends SplitEvent {
  UpdateSpliteeExpenseType({required this.split, required this.splitee, required this.expenseType, required this.isSelected});

  final Split split;
  final Splitee splitee;
  final ExpenseType expenseType;
  final bool isSelected;
}

final class DeleteExpense extends SplitEvent {
  DeleteExpense({required this.split, required this.expense});

  final Split split;
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
