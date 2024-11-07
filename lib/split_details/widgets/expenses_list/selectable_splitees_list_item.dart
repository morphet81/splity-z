import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:provider/provider.dart';

class SelectableSpliteesListItem extends StatelessWidget {
  const SelectableSpliteesListItem({
    required this.split,
    required this.expense,
    required this.splitee,
    required this.isSelected,
    super.key,
  });

  final Split split;
  final Expense expense;
  final Splitee splitee;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(splitee.name)),
        Checkbox(
          value: isSelected,
          onChanged: (newValue) {
            context.read<SplitBloc>().add(
                  UpdateExpensePaidForSplitee(
                    split: split,
                    expense: expense,
                    splitee: splitee,
                    isSelected: isSelected,
                  ),
                );
          },
        ),
      ],
    );
  }
}
