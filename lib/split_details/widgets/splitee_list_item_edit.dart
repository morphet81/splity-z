import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/expanded_selectable_icon.dart';
import 'package:provider/provider.dart';

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
    void Function(bool) onSelectableIconChange(ExpenseType expenseType) {
      return (bool isSelected) {
        debugPrint('Expense $expenseType is ${isSelected ? 'selected' : 'unselected'}');
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
                child: TextFormField(
                  key: Key(widget.splitee.id.toString()),
                  autocorrect: false,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  initialValue: widget.splitee.name,
                  style: Theme.of(context).textTheme.titleMedium,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                  ),
                ),
              ),
              // IconButton(
              //   onPressed: () {
              //     debugPrint('Confirm edit');
              //   },
              //   icon: Icon(Icons.check),
              // )
            ],
          ),
          Text(widget.splitee.name),
          Row(
            children: [
              ExpandedSelectableIcon(
                icon: Icons.restaurant,
                isSelected: widget.splitee.expensesTypes.contains(ExpenseType.Food),
                onChange: onSelectableIconChange(ExpenseType.Food),
              ),
              ExpandedSelectableIcon(
                icon: Icons.local_drink,
                isSelected: widget.splitee.expensesTypes.contains(ExpenseType.Soft),
                onChange: onSelectableIconChange(ExpenseType.Soft),
              ),
              ExpandedSelectableIcon(
                icon: Icons.liquor,
                isSelected: widget.splitee.expensesTypes.contains(ExpenseType.Alcohol),
                onChange: onSelectableIconChange(ExpenseType.Alcohol),
              ),
              ExpandedSelectableIcon(
                icon: Icons.local_taxi,
                isSelected: widget.splitee.expensesTypes.contains(ExpenseType.Taxi),
                onChange: onSelectableIconChange(ExpenseType.Taxi),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
