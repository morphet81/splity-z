import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/shared/widgets/editable_content_pill.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expense_list_item_paid_by_line.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expenses_types.dart';
import 'package:splity_z/split_details/widgets/expenses_list/selectable_splitees_list.dart';

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
              split: widget.split,
              expense: widget.expense,
              expenseType: expenseType,
              isSelected: isSelected,
            ));
      };
    }

    void handleNameChanged(String newName) {
      context.read<SplitBloc>().add(UpdateExpenseName(
            split: widget.split,
            expense: widget.expense,
            name: newName,
          ));
    }

    void handleAmountChanged(String newName) {
      // context.read<SplitBloc>().add(UpdateExpenseName(
      //       split: widget.split,
      //       expense: widget.expense,
      //       name: newName,
      //     ));
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: EditableContentPill(
                    content: widget.expense.name,
                    textAlign: Alignment.centerLeft,
                    onChanged: handleNameChanged,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: EditableContentPill(
                      content: widget.expense.amount.toString(),
                      allowEllipsisOverflow: false,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onChanged: handleAmountChanged,
                    ),
                  ),
                ),
                // Flex(
                //   direction: Axis.horizontal,
                //   mainAxisSize: MainAxisSize.max,
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Switch(
                //       value: isAutoSharingEnabled,
                //       onChanged: handleAutoSharingSwitchChange,
                //     ),
                //   ],
                // )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Row(
                //   children: [
                //     Expanded(
                //       child: InlineTextField(
                //         key: widget.expense.id,
                //         initialValue: widget.expense.name,
                //         textAlign: TextAlign.start,
                //         onChanged: (value) {
                //           context.read<SplitBloc>().add(UpdateExpenseName(
                //                 split: widget.split,
                //                 expense: widget.expense,
                //                 name: value,
                //               ));
                //         },
                //       ),
                //     ),
                //     Switch(
                //       value: isAutoSharingEnabled,
                //       onChanged: handleAutoSharingSwitchChange,
                //     ),
                //   ],
                // ),
                ExpenseListItemPaidByLine(
                  split: widget.split,
                  expense: widget.expense,
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
          ],
        ),
      ),
    );
  }
}
