import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/deletable_list_item_card.dart';
import 'package:splity_z/split_details/widgets/expense_list_item_edit.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({required this.split, required this.expense, required this.isParentInEditMode, super.key});

  final Split split;
  final Expense expense;
  final bool isParentInEditMode;

  @override
  Widget build(BuildContext context) {
    return DeletableListItemCard(
      isInEditMode: isParentInEditMode,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Card.filled(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpenseListItemEdit(splitId: split.id, expense: expense),
                // child: SpliteeListItemEdit(splitId: widget.split.id, splitee: widget.expense),
              ),
            ),
          ),
        ],
      ),
      onTap: () {},
      onDelete: () {
        debugPrint('Delete expense ${expense.name}');
        // context.read<SplitBloc>().add(DeleteSplitee(splitId: widget.split.id, splitee: widget.expense));
      },
    );
  }
}
