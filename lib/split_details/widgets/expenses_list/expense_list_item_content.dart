import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/shared/widgets/editable_content_pill.dart';
import 'package:splity_z/split_details/widgets/expenses_list/auto_manual_share_toggle.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expense_amount.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expenses_types.dart';
import 'package:splity_z/split_details/widgets/expenses_list/selectable_splitees_list.dart';

class ExpenseListItemContent extends StatefulWidget {
  const ExpenseListItemContent({
    required this.split,
    required this.expense,
    super.key,
  });

  final Split split;
  final Expense expense;

  @override
  State<ExpenseListItemContent> createState() => _ExpenseListItemContentState();
}

class _ExpenseListItemContentState extends State<ExpenseListItemContent> {
  void Function(bool) handleSelectableIconChange(ExpenseType expenseType) {
    return (bool isSelected) {
      context.read<SplitBloc>().add(
            UpdateExpenseExpenseType(
              split: widget.split,
              expense: widget.expense,
              expenseType: expenseType,
              isSelected: isSelected,
            ),
          );
    };
  }

  void handleAutoSharingModeChanged(bool value) {
    context.read<SplitBloc>().add(
          UpdateExpenseSharingMode(
            split: widget.split,
            expense: widget.expense,
            isAutoSharingEnabled: value,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _EditableInfoLine(expense: widget.expense, split: widget.split),
          const SizedBox(
            height: 12.0,
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
              Transform.scale(
                scale: 0.8,
                child: AutoManualShareToggle(
                  isAuto: widget.expense.automaticSharing,
                  onChanged: handleAutoSharingModeChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EditableInfoLine extends StatelessWidget {
  const _EditableInfoLine({required this.split, required this.expense});

  final Split split;
  final Expense expense;

  bool get shouldEditName => expense.isBlank();
  bool get shouldEditPayee => !shouldEditName && expense.paidBy.isBlank();
  bool get shouldEditAmount =>
      !shouldEditName && !shouldEditPayee && expense.amount == 0;

  @override
  Widget build(BuildContext context) {
    String paidBySelectorLabel(Splitee splitee) {
      return splitee.name;
    }

    void handledPaidByChanged(Splitee newPaidBy) {
      context.read<SplitBloc>().add(
            UpdateExpensePaidBy(
              split: split,
              expense: expense,
              splitee: newPaidBy,
            ),
          );
    }

    void handleNameChanged(String newName) {
      context.read<SplitBloc>().add(
            UpdateExpenseName(
              split: split,
              expense: expense,
              name: newName,
            ),
          );
    }

    void handleAmountChanged(String newAmount) {
      context.read<SplitBloc>().add(
            UpdateExpenseAmount(
              split: split,
              expense: expense,
              amount: double.parse(newAmount),
            ),
          );
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
                      icon: Icons.description_outlined,
                      textAlign: Alignment.centerLeft,
                      editOnRendered: shouldEditName,
                      onChanged: handleNameChanged,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: EditableContentPill<Splitee>(
                      content: expense.paidBy,
                      icon: Icons.person_outline,
                      textAlign: Alignment.centerLeft,
                      options: split.splitees,
                      editOnRendered: shouldEditPayee,
                      itemLabel: paidBySelectorLabel,
                      onChanged: handledPaidByChanged,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ExpenseAmount(
              expense: expense,
              editOnRendered: shouldEditAmount,
              onAmountChanged: handleAmountChanged,
            ),
          ),
        ),
      ],
    );
  }
}
