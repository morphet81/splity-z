import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/shared/widgets/editable_content_pill.dart';
import 'package:splity_z/split_details/widgets/expenses_list/auto_manual_share_toggle.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expense_amount.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expenses_types.dart';
import 'package:splity_z/split_details/widgets/expenses_list/selectable_splitees_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExpenseListItemContent extends StatefulWidget {
  const ExpenseListItemContent({required this.split, required this.expense, super.key});

  final Split split;
  final Expense expense;

  @override
  State<ExpenseListItemContent> createState() => _ExpenseListItemContentState();
}

class _ExpenseListItemContentState extends State<ExpenseListItemContent> {
  void Function(bool) handleSelectableIconChange(ExpenseType expenseType) {
    return (bool isSelected) {
      context.read<SplitBloc>().add(UpdateExpenseExpenseType(
            split: widget.split,
            expense: widget.expense,
            expenseType: expenseType,
            isSelected: isSelected,
          ));
    };
  }

  void handleAutoSharingModeChanged(bool value) {
    context.read<SplitBloc>().add(UpdateExpenseSharingMode(
          split: widget.split,
          expense: widget.expense,
          isAutoSharingEnabled: value,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _EditableInfoLine(expense: widget.expense, split: widget.split),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(),
            ),
            Column(
              children: [
                widget.expense.automaticSharing
                    ? ExpensesTypes(
                        expensesTypes: widget.expense.expensesTypes,
                        onSelectableIconChange: handleSelectableIconChange,
                      )
                    : SelectableSpliteesList(
                        split: widget.split,
                        expense: widget.expense,
                        selectedSplitees: widget.expense.paidFor,
                      ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Transform.scale(
                    scale: 0.8,
                    child: AutoManualShareToggle(
                      isAuto: widget.expense.automaticSharing,
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

class _EditableInfoLine extends StatelessWidget {
  const _EditableInfoLine({super.key, required this.split, required this.expense});

  final Split split;
  final Expense expense;

  @override
  Widget build(BuildContext context) {
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

    void handleNameChanged(String newName) {
      context.read<SplitBloc>().add(UpdateExpenseName(
            split: split,
            expense: expense,
            name: newName,
          ));
    }

    void handleAmountChanged(String newAmount) {
      context.read<SplitBloc>().add(UpdateExpenseAmount(
            split: split,
            expense: expense,
            amount: double.parse(newAmount),
          ));
    }

    return Row(
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
            padding: const EdgeInsets.only(left: 8.0),
            child: ExpenseAmount(expense: expense, onAmountChanged: handleAmountChanged),
          ),
        ),
      ],
    );
  }
}
