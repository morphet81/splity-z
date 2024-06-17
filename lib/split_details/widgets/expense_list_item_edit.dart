import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/shared/widgets/inline_text_field.dart';
import 'package:splity_z/split_details/widgets/expenses_types.dart';

class ExpenseListItemEdit extends StatefulWidget {
  const ExpenseListItemEdit({required this.splitId, required this.expense, super.key});

  final int splitId;
  final Expense expense;

  @override
  State<ExpenseListItemEdit> createState() => _ExpenseListItemEditState();
}

class _ExpenseListItemEditState extends State<ExpenseListItemEdit> {
  @override
  Widget build(BuildContext context) {
    void Function(bool) handleSelectableIconChange(ExpenseType expenseType) {
      return (bool isSelected) {
        debugPrint('Change seleciton for ${expenseType}');
        // context.read<SplitBloc>().add(UpdateSpliteeExpenseType(
        //       splitId: widget.splitId,
        //       splitee: widget.expense,
        //       expenseType: expenseType,
        //       isSelected: isSelected,
        //     ));
      };
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
                ),
              ),
            ],
          ),
          ExpensesTypes(
            expensesTypes: widget.expense.expensesTypes,
            onSelectableIconChange: handleSelectableIconChange,
          ),
        ],
      ),
    );
  }
}
