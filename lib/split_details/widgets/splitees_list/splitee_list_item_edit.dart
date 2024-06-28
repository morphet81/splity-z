import 'package:flutter/material.dart' hide Split;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/shared/widgets/editable_content_pill.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expenses_types.dart';

class SpliteeListItemEdit extends StatefulWidget {
  const SpliteeListItemEdit({required this.split, required this.splitee, super.key});

  final Split split;
  final Splitee splitee;

  @override
  State<SpliteeListItemEdit> createState() => _SpliteeListItemEditState();
}

class _SpliteeListItemEditState extends State<SpliteeListItemEdit> {
  @override
  Widget build(BuildContext context) {
    void Function(bool) handleSelectableIconChange(ExpenseType expenseType) {
      return (bool isSelected) {
        context.read<SplitBloc>().add(UpdateSpliteeExpenseType(
              split: widget.split,
              splitee: widget.splitee,
              expenseType: expenseType,
              isSelected: isSelected,
            ));
      };
    }

    void handleNameChange(String newName) {
      context.read<SplitBloc>().add(UpdateSpliteeName(
            split: widget.split,
            splitee: widget.splitee,
            name: newName,
          ));
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            EditableContentPill(
              content: widget.splitee.name,
              onChanged: handleNameChange,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(),
            ),
            ExpensesTypes(
              expensesTypes: widget.splitee.expensesTypes,
              onSelectableIconChange: handleSelectableIconChange,
            ),
          ],
        ),
      ),
    );
  }
}
