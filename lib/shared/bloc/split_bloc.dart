import 'package:equatable/equatable.dart';
import 'package:replay_bloc/replay_bloc.dart';
import 'package:splity_z/shared/extensions/extensions.dart';
import 'package:splity_z/shared/models/models.dart';

part 'split_event.dart';
part 'split_state.dart';

class SplitBloc extends ReplayBloc<SplitEvent, SplitState> {
  SplitBloc() : super(SplitState.initialState) {
    on<DeleteSplit>(_onDeleteSplit);
    on<DeleteSplitee>(_onDeleteSplitee);
    on<UpdateSpliteeName>(_onUpdateSpliteeName);
    on<UpdateSpliteeExpenseType>(_onUpdateSpliteeExpenseType);
    on<DeleteExpense>(_onDeleteExpense);
    on<UpdateExpenseName>(_onUpdateExpenseName);
    on<UpdateExpenseAmount>(_onUpdateExpenseAmount);
    on<UpdateExpenseExpenseType>(_onUpdateExpenseExpenseType);
    on<UpdateExpenseSharingMode>(_onUpdateExpenseSharingMode);
    on<UpdateExpensePaidForSplitee>(_onUpdateExpensePaidForSplitee);
    on<UpdateExpensePaidBy>(_onUpdateExpensePaidBy);
  }

  Future<void> _onDeleteSplit(DeleteSplit event, Emitter<SplitState> emit) async {
    List<Split> newSplitsList = List.from(state.splits);

    newSplitsList.removeWhere((split) => split.id == event.split.id);

    emit(state.copyWith(splits: newSplitsList));
  }

  Future<void> _onDeleteSplitee(DeleteSplitee event, Emitter<SplitState> emit) async {
    final newExpenses = event.split.expenses.where((expense) => expense.paidBy != event.splitee).toList();

    final newSplit = event.split.copyWith(
      splitees: List.from(event.split.splitees)..remove(event.splitee),
      expenses: newExpenses,
    );

    final newState = state.copyWith(
      splits: List.from(state.splits)..replace(event.split, newSplit),
    );

    emit(newState);
  }

  Future<void> _onUpdateSpliteeName(UpdateSpliteeName event, Emitter<SplitState> emit) async {
    final newSplitee = event.splitee.copyWith(name: event.name);

    final newSplitees = event.split.splitees.toList()..replace(event.splitee, newSplitee);

    List<Expense> newExpenses = [];

    event.split.expenses.forEach((expense) {
      final newPaidBy = expense.paidBy == event.splitee ? newSplitee : expense.paidBy;
      final newPaidFor = expense.paidFor.toList()..replace(event.splitee, newSplitee);
      final newManualPaidFor = expense.manualPaidFor == null ? null : expense.manualPaidFor;

      if (newManualPaidFor != null) {
        newManualPaidFor.toList().replace(event.splitee, newSplitee);
      }

      newExpenses.add(expense.copyWith(paidBy: newPaidBy, paidFor: newPaidFor, manualPaidFor: newManualPaidFor));
    });

    final newSplit = event.split.copyWith(
      splitees: newSplitees,
      expenses: newExpenses,
    );

    final newState = state.copyWith(
      splits: List.from(state.splits)..replace(event.split, newSplit),
    );

    emit(newState);
  }

  Future<void> _onUpdateSpliteeExpenseType(UpdateSpliteeExpenseType event, Emitter<SplitState> emit) async {
    List<ExpenseType> newExpenseTypes = event.splitee.expensesTypes.toList();

    newExpenseTypes.updateForExpenseType(event.expenseType, event.isSelected);

    final newSplitee = event.splitee.copyWith(expensesTypes: newExpenseTypes);

    final newExpenses = event.split.expenses.copyWithNewSplitee(newSplitee);

    final Split newSplit = event.split.copyWith(
      splitees: event.split.splitees.toList()..replace(event.splitee, newSplitee),
      expenses: newExpenses,
    );

    final newState = state.copyWith(
      splits: state.splits.toList()..replace(event.split, newSplit),
    );

    emit(newState);
  }

  Future<void> _onDeleteExpense(DeleteExpense event, Emitter<SplitState> emit) async {
    final newSplit = event.split.copyWith(
      expenses: List.from(event.split.expenses)..remove(event.expense),
    );

    final newState = state.copyWith(
      splits: List.from(state.splits)..replace(event.split, newSplit),
    );

    emit(newState);
  }

  Future<void> _onUpdateExpenseName(UpdateExpenseName event, Emitter<SplitState> emit) async {
    final newExpense = event.expense.copyWith(name: event.name);

    final newSplit = event.split.copyWith(
      expenses: List.from(event.split.expenses)..replace(event.expense, newExpense),
    );

    final newState = state.copyWith(
      splits: List.from(state.splits)..replace(event.split, newSplit),
    );

    emit(newState);
  }

  Future<void> _onUpdateExpenseAmount(UpdateExpenseAmount event, Emitter<SplitState> emit) async {
    final newExpense = event.expense.copyWith(amount: event.amount);

    final newSplit = event.split.copyWith(
      expenses: List.from(event.split.expenses)..replace(event.expense, newExpense),
    );

    final newState = state.copyWith(
      splits: List.from(state.splits)..replace(event.split, newSplit),
    );

    emit(newState);
  }

  Future<void> _onUpdateExpenseExpenseType(UpdateExpenseExpenseType event, Emitter<SplitState> emit) async {
    List<ExpenseType> newExpenseTypes = event.expense.expensesTypes.toList();

    newExpenseTypes.updateForExpenseType(event.expenseType, event.isSelected);

    final newPaidFor = event.split.splitees.containingExpenseTypes(newExpenseTypes);

    final newExpense = event.expense.copyWith(expensesTypes: newExpenseTypes, paidFor: newPaidFor);
    final newState = _updateExpense(event.split, event.expense, newExpense);

    emit(newState);
  }

  Future<void> _onUpdateExpenseSharingMode(UpdateExpenseSharingMode event, Emitter<SplitState> emit) async {
    Expense newExpense;

    if (event.isAutoSharingEnabled) {
      newExpense = event.expense.copyWithAutomaticSharing(event.split.splitees);
    } else {
      newExpense = event.expense.copyWithoutAutomaticSharing();
    }

    final newState = _updateExpense(event.split, event.expense, newExpense);

    emit(newState);
  }

  Future<void> _onUpdateExpensePaidForSplitee(UpdateExpensePaidForSplitee event, Emitter<SplitState> emit) async {
    final expense = event.split.expenses.where((expense) => expense == event.expense).firstOrNull;

    if (expense != null) {
      List<Splitee> newPaidFor = expense.paidFor.toList();

      if (event.isSelected) {
        newPaidFor.remove(event.splitee);
      } else {
        newPaidFor.add(event.splitee);
      }

      final newExpense = expense.copyWith(paidFor: newPaidFor);
      final newState = _updateExpense(event.split, expense, newExpense);

      emit(newState);
    }
  }

  Future<void> _onUpdateExpensePaidBy(UpdateExpensePaidBy event, Emitter<SplitState> emit) async {
    final expense = event.split.expenses.where((expense) => expense == event.expense).firstOrNull;

    if (expense != null) {
      final newExpense = expense.copyWith(paidBy: event.splitee);
      final newState = _updateExpense(event.split, expense, newExpense);

      emit(newState);
    }
  }

  SplitState _updateExpense(Split split, Expense oldExpense, Expense newExpense) {
    final Split newSplit = split.copyWith(
      expenses: split.expenses.toList()..replace(oldExpense, newExpense),
    );

    final newState = state.copyWith(
      splits: state.splits.toList()..replace(split, newSplit),
    );

    return newState;
  }
}
