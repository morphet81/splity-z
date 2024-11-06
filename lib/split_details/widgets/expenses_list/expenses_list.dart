import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/add_item_button.dart';
import 'package:splity_z/shared/widgets/no_items.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expense_list_item.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({required this.split, super.key});

  final Split split;

  @override
  Widget build(BuildContext context) {
    void handleAddExpensePressed() {
      context.read<SplitBloc>().add(AddExpense(split: split));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
        child: Column(
          children: [
            _ExpensesList(split: split),
            AddItemButton(
              label: context.localizations.addExpense,
              onPressed: handleAddExpensePressed,
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpensesList extends StatelessWidget {
  const _ExpensesList({
    required this.split,
  });

  final Split split;

  @override
  Widget build(BuildContext context) {
    if (split.expenses.isEmpty) {
      return NoItems(
        message: context.localizations.expensesListNoExpenses,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final expense = split.expenses[index];

        return ExpenseListItem(
          split: split,
          expense: expense,
        );
      },
      itemCount: split.expenses.length,
    );
  }
}
