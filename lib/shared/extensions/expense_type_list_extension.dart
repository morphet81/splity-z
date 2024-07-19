import 'package:splity_z/shared/models/models.dart';

extension Expensetypelistextension on List<ExpenseType> {
  void updateForExpenseType(ExpenseType expenseType, bool isSelected) {
    if (isSelected && !this.contains(expenseType)) {
      this.add(expenseType);
    } else if (!isSelected && this.contains((expenseType))) {
      this.remove(expenseType);
    }
  }
}
