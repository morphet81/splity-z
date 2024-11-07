import 'package:flutter/material.dart' hide Split;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/shared/widgets/editable_content_pill.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expenses_types.dart';

class SpliteeListItemContent extends StatelessWidget {
  const SpliteeListItemContent({
    required this.split,
    required this.splitee,
    super.key,
  });

  final Split split;
  final Splitee splitee;

  @override
  Widget build(BuildContext context) {
    bool shouldEditName = splitee.isBlank();

    void Function(bool) handleSelectableIconChange(ExpenseType expenseType) {
      return (bool isSelected) {
        context.read<SplitBloc>().add(
              UpdateSpliteeExpenseType(
                split: split,
                splitee: splitee,
                expenseType: expenseType,
                isSelected: isSelected,
              ),
            );
      };
    }

    void handleNameChange(String newName) {
      context.read<SplitBloc>().add(
            UpdateSpliteeName(
              split: split,
              splitee: splitee,
              name: newName,
            ),
          );
    }

    void handleDismissedNewSpliteesWithoutName() {
      context.read<SplitBloc>().add(
            DeleteSplitee(
              split: split,
              splitee: splitee,
            ),
          );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: EditableContentPill(
            content: splitee.name,
            onChanged: handleNameChange,
            editOnRendered: shouldEditName,
            onDismissedWithoutValue: handleDismissedNewSpliteesWithoutName,
          ),
        ),
        ExpensesTypes(
          expensesTypes: splitee.expensesTypes,
          onSelectableIconChange: handleSelectableIconChange,
        ),
      ],
    );
  }
}
