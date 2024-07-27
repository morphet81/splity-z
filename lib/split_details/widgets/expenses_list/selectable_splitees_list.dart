import 'package:flutter/material.dart' hide Split;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/extensions/extensions.dart';
import 'package:splity_z/split_details/widgets/expenses_list/selectable_splitees_list_item.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';

class SelectableSpliteesList extends StatelessWidget {
  const SelectableSpliteesList(
      {required this.split,
      required this.expense,
      required this.selectedSplitees,
      super.key});

  final Split split;
  final Expense expense;
  final List<Splitee> selectedSplitees;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplitBloc, SplitState>(builder: (context, state) {
      final splitees = split.splitees;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              context.localizations.paidFor,
              style: context.textTheme.labelLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final currentSplitee = splitees[index];

                return SelectableSpliteesListItem(
                  split: split,
                  expense: expense,
                  splitee: currentSplitee,
                  isSelected: selectedSplitees.contains(currentSplitee),
                );
              },
              itemCount: splitees.length,
            ),
          )
        ],
      );
    });
  }
}
