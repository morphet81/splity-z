import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/extensions/ListExtension.dart';

part 'split_event.dart';
part 'split_state.dart';

class SplitBloc extends Bloc<SplitEvent, SplitState> {
  SplitBloc() : super(SplitState.initialState) {
    on<DeleteSplit>(_onDeleteSplit);
    on<DeleteSplitee>(_onDeleteSplitee);
    on<UpdateSpliteeExpenseType>(_onUpdateSpliteeExpenseType);
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

      if (event.isSelected && !newExpenseTypes.contains(event.expenseType)) {
        newExpenseTypes.add(event.expenseType);
      } else if (!event.isSelected && newExpenseTypes.contains((event.expenseType))) {
        newExpenseTypes.remove(event.expenseType);
      }

      final splitee = split.splitees.where((splitee) => splitee == event.splitee).firstOrNull;

      if (splitee != null) {
        final newSplitee = splitee.copyWith(expensesTypes: newExpenseTypes);

        final Split newSplit = split.copyWith(
          splitees: split.splitees.toList()..replace(splitee, newSplitee),
        );

        final newState = state.copyWith(
          splits: state.splits.toList()..replace(split, newSplit),
        );

        emit(newState);
      }
    }
  }
}
