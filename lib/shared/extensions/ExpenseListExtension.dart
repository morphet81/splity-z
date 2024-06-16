import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

extension Expenselistextension on List<Expense> {
  List<Expense> copyWithNewSplitee(Splitee splitee) {
    return this.map((expense) {
      final paidForSplitee = expense.paidFor.where((s) => s.id == splitee.id).firstOrNull;

      if (expense.paidBy.id == splitee.id) {
        return expense.copyWith(paidBy: splitee);
      } else if (paidForSplitee != null) {
        return expense.copyWith(
          paidFor: expense.paidFor.toList()..replace(paidForSplitee, splitee),
        );
      }

      return expense;
    }).toList();
  }
}
