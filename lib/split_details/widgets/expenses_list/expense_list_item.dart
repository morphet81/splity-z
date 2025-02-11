import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/deletable_list_item.dart';
import 'package:splity_z/shared/widgets/editable_content_change_dialog/splityz_card.dart';
import 'package:splity_z/split_details/widgets/expandable_content.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expense_list_item_content.dart';
import 'package:provider/provider.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({
    required this.split,
    required this.expense,
    required this.isExpanded,
    required this.onExpandChanged,
    super.key,
  });

  final Split split;
  final Expense expense;
  final bool isExpanded;
  final ValueChanged<bool> onExpandChanged;

  void handleDeletion(BuildContext context) {
    context
        .read<SplitBloc>()
        .add(DeleteExpense(split: split, expense: expense));
  }

  void handleExpandableChanged(bool isExpanded) {
    onExpandChanged(isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return DeletableListItem(
      key: expense.id,
      child: SplityzCard(
        child: ExpandableContent(
          title: expense.name,
          isExpanded: isExpanded,
          onChanged: handleExpandableChanged,
          child: ExpenseListItemContent(
            split: split,
            expense: expense,
          ),
        ),
      ),
      onDelete: () => handleDeletion(context),
    );
  }
}
