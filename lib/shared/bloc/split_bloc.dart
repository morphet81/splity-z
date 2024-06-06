import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:splity_z/shared/models/models.dart';

part 'split_event.dart';
part 'split_state.dart';

class SplitBloc extends Bloc<SplitEvent, SplitState> {
  SplitBloc() : super(SplitState.initialState) {
    on<DeleteSplit>(_onDeleteSplit);
    on<DeleteSplitee>(_onDeleteSplitee);
  }

  Future<void> _onDeleteSplit(DeleteSplit event, Emitter<SplitState> emit) async {
    List<Split> newSplitsList = List.from(state.splits);

    newSplitsList.removeWhere((split) => split.id == event.splitId);

    emit(state.copyWith(splits: newSplitsList));
  }

  Future<void> _onDeleteSplitee(DeleteSplitee event, Emitter<SplitState> emit) async {
    final split = state.splits.where((split) => split.id == event.splitId).firstOrNull;

    if (split != null) {
      final newSplit = split.copyWith(
        splitees: split.splitees..remove(event.splitee),
      );

      List<Split> newSplitsList = List.from(
        state.splits..remove(split),
      )..add(newSplit);

      emit(state.copyWith(splits: newSplitsList));
    }
  }
}
