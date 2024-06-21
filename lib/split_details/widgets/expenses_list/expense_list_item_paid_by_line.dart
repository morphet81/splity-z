import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:provider/provider.dart';

class ExpenseListItemPaidByLine extends StatelessWidget {
  const ExpenseListItemPaidByLine({required this.split, required this.expense, super.key});

  final Split split;
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Text('Paid by: '),
        ),
        Expanded(
          child: DropdownButton<Splitee>(
            isExpanded: true,
            value: expense.paidBy,
            items: split.splitees.map<DropdownMenuItem<Splitee>>((Splitee splitee) {
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
                      split: split,
                      expense: expense,
                      splitee: splitee,
                    ));
              }
            },
          ),
        ),
      ],
    );
  }
}
