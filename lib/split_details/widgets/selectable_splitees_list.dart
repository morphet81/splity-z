import 'package:flutter/material.dart' hide Split;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/split_details/widgets/selectable_splitees_list_item.dart';

import '../../shared/models/models.dart';

class SelectableSpliteesList extends StatelessWidget {
  const SelectableSpliteesList({required this.splitId, required this.expense, required this.selectedSplitees, super.key});

  final int splitId;
  final Expense expense;
  final List<Splitee> selectedSplitees;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplitBloc, SplitState>(builder: (context, state) {
      final Split? split = state.findSplitWithId(splitId);

      if (split == null) {
        GoRouter.of(context).replace('/error');
        return Container();
      }

      final splitees = split.splitees;

      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final currentSplitee = splitees[index];

          return SelectableSpliteesListItem(
            splitId: splitId,
            expense: expense,
            splitee: currentSplitee,
            isSelected: selectedSplitees.contains(currentSplitee),
          );
        },
        itemCount: splitees.length,
      );
    });
  }
}
