import 'package:splity_z/shared/models/models.dart';

extension Expensetypelistextension on List<ExpenseType> {
  void updateForExpenseType(ExpenseType expenseType, bool isSelected) {
    if (isSelected && !contains(expenseType)) {
      add(expenseType);
    } else if (!isSelected && contains((expenseType))) {
      remove(expenseType);
    }
  }
}
