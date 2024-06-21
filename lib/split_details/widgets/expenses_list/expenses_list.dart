import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expense_list_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({required this.split, required this.isInEditMode, super.key});

  final Split split;
  final bool isInEditMode;

  @override
  Widget build(BuildContext context) {
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
                final expense = split.expenses[index];
                return ExpenseListItem(split: split, expense: expense, isParentInEditMode: isInEditMode);
              },
              itemCount: split.expenses.length,
            ),
          ),
        ],
      ),
    );
  }
}
