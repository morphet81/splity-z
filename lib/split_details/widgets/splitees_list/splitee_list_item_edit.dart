import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/shared/widgets/inline_text_field.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expenses_types.dart';

class SpliteeListItemEdit extends StatefulWidget {
  const SpliteeListItemEdit({required this.splitId, required this.splitee, super.key});

  final int splitId;
  final Splitee splitee;

  @override
  State<SpliteeListItemEdit> createState() => _SpliteeListItemEditState();
}

class _SpliteeListItemEditState extends State<SpliteeListItemEdit> {
  @override
  Widget build(BuildContext context) {
    void Function(bool) handleSelectableIconChange(ExpenseType expenseType) {
      return (bool isSelected) {
        context.read<SplitBloc>().add(UpdateSpliteeExpenseType(
              splitId: widget.splitId,
              splitee: widget.splitee,
              expenseType: expenseType,
              isSelected: isSelected,
            ));
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
                  key: widget.splitee.id,
                  initialValue: widget.splitee.name,
                ),
              ),
            ],
          ),
          ExpensesTypes(
            expensesTypes: widget.splitee.expensesTypes,
            onSelectableIconChange: handleSelectableIconChange,
          ),
        ],
      ),
    );
  }
}
