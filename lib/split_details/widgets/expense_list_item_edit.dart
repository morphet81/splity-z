import 'package:flutter/material.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/shared/widgets/inline_text_field.dart';
import 'package:splity_z/split_details/widgets/expenses_types.dart';
import 'package:splity_z/split_details/widgets/selectable_splitees_list.dart';

class ExpenseListItemEdit extends StatefulWidget {
  const ExpenseListItemEdit({required this.splitId, required this.expense, super.key});

  final int splitId;
  final Expense expense;

  @override
  State<ExpenseListItemEdit> createState() => _ExpenseListItemEditState();
}

class _ExpenseListItemEditState extends State<ExpenseListItemEdit> {
  bool isAutoSharingEnabled = false;

  @override
  void initState() {
    isAutoSharingEnabled = widget.expense.automaticSharing;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void Function(bool) handleSelectableIconChange(ExpenseType expenseType) {
      return (bool isSelected) {
        context.read<SplitBloc>().add(UpdateExpenseExpenseType(
              splitId: widget.splitId,
              expense: widget.expense,
              expenseType: expenseType,
              isSelected: isSelected,
            ));
      };
    }

    void handleAutoSharingSwitchChange(bool value) {
      context.read<SplitBloc>().add(UpdateExpenseSharingMode(
            splitId: widget.splitId,
            expense: widget.expense,
            isAutoSharingEnabled: value,
          ));

      setState(() {
        isAutoSharingEnabled = value;
      });
    }

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: InlineTextField(
                  key: widget.expense.id,
                  initialValue: widget.expense.name,
                  textAlign: TextAlign.start,
                ),
              ),
              Switch(
                value: isAutoSharingEnabled,
                onChanged: handleAutoSharingSwitchChange,
              ),
            ],
          ),
          widget.expense.automaticSharing
              ? ExpensesTypes(
                  expensesTypes: widget.expense.expensesTypes,
                  onSelectableIconChange: handleSelectableIconChange,
                )
              : SelectableSpliteesList(
                  splitId: widget.splitId,
                  expense: widget.expense,
                  selectedSplitees: widget.expense.paidFor,
                ),
        ],
      ),
    );
  }
}
