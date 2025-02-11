import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/add_item_button.dart';
import 'package:splity_z/shared/widgets/no_items.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expense_list_item.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({required this.split, super.key});

  final Split split;

  @override
  Widget build(BuildContext context) {
    void handleAddExpensePressed() {
      context.read<SplitBloc>().add(AddExpense(split: split));
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          AddItemButton(
            label: context.localizations.addExpense,
            onPressed: handleAddExpensePressed,
          ),
          _ExpensesList(split: split),
        ],
      ),
    );
  }
}

class _ExpensesList extends StatefulWidget {
  const _ExpensesList({
    required this.split,
  });

  final Split split;

  @override
  State<_ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<_ExpensesList> {
  late List<bool> areExpensesExpanded;

  List<Expense> get expenses {
    return widget.split.expenses;
  }

  @override
  void initState() {
    super.initState();

    areExpensesExpanded = List<bool>.generate(expenses.length, (_) => false);
  }

  ValueChanged<bool> handleExpenseExpands(int expandedIndex) {
    return (bool isExpanded) {
      setState(() {
        areExpensesExpanded = List<bool>.generate(
          expenses.length,
          (int index) {
            if (expandedIndex == index) {
              return isExpanded;
            }
            return false;
          },
        );
      });
    };
  }

  @override
  void didUpdateWidget(covariant _ExpensesList oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      areExpensesExpanded = List<bool>.generate(
        expenses.length,
        (int index) {
          if (areExpensesExpanded.length > index) {
            return areExpensesExpanded[index];
          }
          return false;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.split.expenses.isEmpty) {
      return NoItems(
        message: context.localizations.expensesListNoExpenses,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final expense = expenses[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: ExpenseListItem(
            split: widget.split,
            expense: expense,
            isExpanded: areExpensesExpanded[index],
            onExpandChanged: handleExpenseExpands(index),
          ),
        );
      },
      itemCount: expenses.length,
    );
  }
}
