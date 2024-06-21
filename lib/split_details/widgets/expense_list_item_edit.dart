import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/shared/widgets/inline_text_field.dart';
import 'package:splity_z/split_details/widgets/expenses_types.dart';
import 'package:splity_z/split_details/widgets/selectable_splitees_list.dart';

class ExpenseListItemEdit extends StatefulWidget {
  const ExpenseListItemEdit({required this.split, required this.expense, super.key});

  final Split split;
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
              splitId: widget.split.id,
              expense: widget.expense,
              expenseType: expenseType,
              isSelected: isSelected,
            ));
      };
    }

    void handleAutoSharingSwitchChange(bool value) {
      context.read<SplitBloc>().add(UpdateExpenseSharingMode(
            split: widget.split,
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Text('Paid by: '),
              ),
              Expanded(
                child: DropdownButton<Splitee>(
                  isExpanded: true,
                  value: widget.expense.paidBy,
                  items: widget.split.splitees.map<DropdownMenuItem<Splitee>>((Splitee splitee) {
                    return DropdownMenuItem<Splitee>(
                      value: splitee,
                      child: Text(
                        splitee.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (Splitee? splitee) {
                    if (splitee != null) {
                      context.read<SplitBloc>().add(UpdateExpensePaidBy(
                            split: widget.split,
                            expense: widget.expense,
                            splitee: splitee,
                          ));
                    }
                  },
                ),
              ),
            ],
          ),
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
        ],
      ),
    );
  }
}
