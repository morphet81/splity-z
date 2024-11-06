import 'package:flutter/material.dart';
import 'package:splity_z/shared/models/models.dart';

import '../../../shared/widgets/selectable_icon.dart';

class ExpensesTypes extends StatelessWidget {
  const ExpensesTypes(
      {required this.expensesTypes,
      required this.onSelectableIconChange,
      super.key});

  final List<ExpenseType> expensesTypes;
  final Function(bool) Function(ExpenseType) onSelectableIconChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SelectableIcon(
            icon: Icons.restaurant,
            isSelected: expensesTypes.contains(ExpenseType.Food),
            onChange: onSelectableIconChange(ExpenseType.Food),
          ),
          _Spacing(),
          SelectableIcon(
            icon: Icons.local_drink,
            isSelected: expensesTypes.contains(ExpenseType.Soft),
            onChange: onSelectableIconChange(ExpenseType.Soft),
          ),
          _Spacing(),
          SelectableIcon(
            icon: Icons.liquor,
            isSelected: expensesTypes.contains(ExpenseType.Alcohol),
            onChange: onSelectableIconChange(ExpenseType.Alcohol),
          ),
          _Spacing(),
          SelectableIcon(
            icon: Icons.local_taxi,
            isSelected: expensesTypes.contains(ExpenseType.Taxi),
            onChange: onSelectableIconChange(ExpenseType.Taxi),
          ),
        ],
      ),
    );
  }
}

class _Spacing extends StatelessWidget {
  const _Spacing();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 12,
    );
  }
}
