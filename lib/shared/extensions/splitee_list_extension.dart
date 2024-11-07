import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

extension SpliteeListExtension on List<Splitee> {
  List<Splitee> ascendingSortList() {
    return this..sort((a, b) => a.name.compareTo(b.name));
  }

  List<Splitee> containingExpenseTypes(List<ExpenseType> expenseTypes) {
    return toList().where((splitee) {
      return splitee.expensesTypes.containsAny(expenseTypes);
    }).toList();
  }
}
