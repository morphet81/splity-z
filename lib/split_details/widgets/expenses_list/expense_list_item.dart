import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/deletable_list_item.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expense_list_item_content.dart';
import 'package:provider/provider.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({required this.split, required this.expense, required this.isParentInEditMode, super.key});

  final Split split;
  final Expense expense;
  final bool isParentInEditMode;

  @override
  Widget build(BuildContext context) {
    return DeletableListItem(
      isInEditMode: isParentInEditMode,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Card.filled(
              elevation: 1,
              child: Padding(
                padding: EdgeInsets.zero,
                child: ExpenseListItemContent(split: split, expense: expense),
              ),
            ),
          ),
        ],
      ),
      onTap: () {},
      onDelete: () {
        context.read<SplitBloc>().add(DeleteExpense(split: split, expense: expense));
      },
    );
  }
}
