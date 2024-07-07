import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:splity_z/shared/widgets/add_item_button.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expense_list_item.dart';
import 'package:provider/provider.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({required this.split, required this.isInEditMode, super.key});

  final Split split;
  final bool isInEditMode;

  @override
  Widget build(BuildContext context) {
    void handleAddExpensePressed() {
      context.read<SplitBloc>().add(AddExpense(split: split));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              AppLocalizations.of(context)!.expensesListTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Center(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == split.expenses.length) {
                  return AddItemButton(
                    onPressed: isInEditMode ? null : handleAddExpensePressed,
                  );
                }

                final expense = split.expenses[index];

                return ExpenseListItem(split: split, expense: expense, isParentInEditMode: isInEditMode);
              },
              itemCount: split.expenses.length + 1,
            ),
          ),
        ],
      ),
    );
  }
}
