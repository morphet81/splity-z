import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/deletable_list_item.dart';
import 'package:splity_z/shared/widgets/editable_content_change_dialog/splityz_card.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expense_list_item_content.dart';
import 'package:provider/provider.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem(
      {required this.split,
      required this.expense,
      required this.isParentInEditMode,
      super.key});

  final Split split;
  final Expense expense;
  final bool isParentInEditMode;

  void handleDeletion(BuildContext context) {
    context
        .read<SplitBloc>()
        .add(DeleteExpense(split: split, expense: expense));
  }

  @override
  Widget build(BuildContext context) {
    return DeletableListItem(
      key: expense.id,
      isInEditMode: isParentInEditMode,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: SplityzCard(
              child: ExpenseListItemContent(split: split, expense: expense),
            ),
          ),
        ],
      ),
      onDelete: () => handleDeletion(context),
    );
  }
}
