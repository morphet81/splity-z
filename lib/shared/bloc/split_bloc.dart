import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:splity_z/shared/extensions/extensions.dart';
import 'package:splity_z/shared/models/models.dart';

part 'split_event.dart';
part 'split_state.dart';

class SplitBloc extends Bloc<SplitEvent, SplitState> {
  SplitBloc() : super(SplitState.initialState) {
    on<DeleteSplit>(_onDeleteSplit);
    on<DeleteSplitee>(_onDeleteSplitee);
    on<UpdateSpliteeExpenseType>(_onUpdateSpliteeExpenseType);
    on<DeleteExpense>(_onDeleteExpense);
    on<UpdateExpenseExpenseType>(_onUpdateExpenseExpenseType);
  }

  Future<void> _onDeleteSplit(DeleteSplit event, Emitter<SplitState> emit) async {
    List<Split> newSplitsList = List.from(state.splits);

    newSplitsList.removeWhere((split) => split.id == event.splitId);

    emit(state.copyWith(splits: newSplitsList));
  }

  Future<void> _onDeleteSplitee(DeleteSplitee event, Emitter<SplitState> emit) async {
    final split = state.findSplitWithId(event.splitId);

    if (split != null) {
      final newSplit = split.copyWith(
        splitees: List.from(split.splitees)..remove(event.splitee),
      );

      final newState = state.copyWith(
        splits: List.from(state.splits)..replace(split, newSplit),
      );

      emit(newState);
    }
  }

  Future<void> _onUpdateSpliteeExpenseType(UpdateSpliteeExpenseType event, Emitter<SplitState> emit) async {
    final split = state.findSplitWithId(event.splitId);

    if (split != null) {
      List<ExpenseType> newExpenseTypes = event.splitee.expensesTypes.toList();

      newExpenseTypes.updateForExpenseType(event.expenseType, event.isSelected);

      final splitee = split.splitees.where((splitee) => splitee == event.splitee).firstOrNull;

      if (splitee != null) {
        final newSplitee = splitee.copyWith(expensesTypes: newExpenseTypes);

        final newExpenses = split.expenses.copyWithNewSplitee(newSplitee);

        final Split newSplit = split.copyWith(
          splitees: split.splitees.toList()..replace(splitee, newSplitee),
          expenses: newExpenses,
        );

        final newState = state.copyWith(
          splits: state.splits.toList()..replace(split, newSplit),
        );

        emit(newState);
      }
    }
  }

  Future<void> _onDeleteExpense(DeleteExpense event, Emitter<SplitState> emit) async {
    final split = state.findSplitWithId(event.splitId);

    if (split != null) {
      final newSplit = split.copyWith(
        expenses: List.from(split.expenses)..remove(event.expense),
      );

      final newState = state.copyWith(
        splits: List.from(state.splits)..replace(split, newSplit),
      );

      emit(newState);
    }
  }

  Future<void> _onUpdateExpenseExpenseType(UpdateExpenseExpenseType event, Emitter<SplitState> emit) async {
    final split = state.findSplitWithId(event.splitId);

    if (split != null) {
      List<ExpenseType> newExpenseTypes = event.expense.expensesTypes.toList();

      newExpenseTypes.updateForExpenseType(event.expenseType, event.isSelected);

      final expense = split.expenses.where((expense) => expense == event.expense).firstOrNull;

      if (expense != null) {
        final newExpense = expense.copyWith(expensesTypes: newExpenseTypes);

        final Split newSplit = split.copyWith(
          expenses: split.expenses.toList()..replace(expense, newExpense),
        );

        final newState = state.copyWith(
          splits: state.splits.toList()..replace(split, newSplit),
        );

        emit(newState);
      }
    }
  }
}
