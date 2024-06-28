import 'dart:math';

import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/shared/widgets/editable_content_pill.dart';
import 'package:splity_z/split_details/widgets/expenses_list/auto_manual_share_toggle.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expenses_types.dart';
import 'package:splity_z/split_details/widgets/expenses_list/selectable_splitees_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExpenseListItemEdit extends StatelessWidget {
  const ExpenseListItemEdit({required this.split, required this.expense, super.key});

  final Split split;
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    void Function(bool) handleSelectableIconChange(ExpenseType expenseType) {
      return (bool isSelected) {
        context.read<SplitBloc>().add(UpdateExpenseExpenseType(
              split: split,
              expense: expense,
              expenseType: expenseType,
              isSelected: isSelected,
            ));
      };
    }

    void handleNameChanged(String newName) {
      context.read<SplitBloc>().add(UpdateExpenseName(
            split: split,
            expense: expense,
            name: newName,
          ));
    }

    String paidBySelectorLabel(Splitee splitee) {
      return splitee.name;
    }

    void handledPaidByChanged(Splitee newPaidBy) {
      context.read<SplitBloc>().add(UpdateExpensePaidBy(
            split: split,
            expense: expense,
            splitee: newPaidBy,
          ));
    }

    void handleAmountChanged(String newAmount) {
      context.read<SplitBloc>().add(UpdateExpenseAmount(
            split: split,
            expense: expense,
            amount: double.parse(newAmount),
          ));
    }

    void handleAutoSharingModeChanged(bool value) {
      context.read<SplitBloc>().add(UpdateExpenseSharingMode(
            split: split,
            expense: expense,
            isAutoSharingEnabled: value,
          ));
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: EditableContentPill<String>(
                              content: expense.name,
                              textAlign: Alignment.centerLeft,
                              onChanged: handleNameChanged,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              AppLocalizations.of(context)!.paidBy,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                          Expanded(
                            child: EditableContentPill<Splitee>(
                              content: expense.paidBy,
                              textAlign: Alignment.centerLeft,
                              options: split.splitees,
                              itemLabel: paidBySelectorLabel,
                              onChanged: handledPaidByChanged,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: EditableContentPill<String>(
                      content: expense.amount.toString(),
                      allowEllipsisOverflow: false,
                      isRound: true,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onChanged: handleAmountChanged,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Divider(),
            ),
            Column(
              children: [
                expense.automaticSharing
                    ? ExpensesTypes(
                        expensesTypes: expense.expensesTypes,
                        onSelectableIconChange: handleSelectableIconChange,
                      )
                    : SelectableSpliteesList(
                        split: split,
                        expense: expense,
                        selectedSplitees: expense.paidFor,
                      ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Transform.scale(
                    scale: 0.8,
                    child: AutoManualShareToggle(
                      isAuto: expense.automaticSharing,
                      onChanged: handleAutoSharingModeChanged,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
