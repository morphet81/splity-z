import 'package:splity_z/shared/models/models.dart';

extension Expenselistextension on List<Expense> {
  List<Expense> copyWithNewSplitee(Splitee splitee) {
    Expense updateExpense(Expense expense) {
      if (expense.isPaidBy(splitee)) {
        return expense.copyWith(paidBy: splitee);
      } else if (expense.isPaidFor(splitee)) {
        final paidForSplitee = expense.paidForSpliteeMatching(splitee)!;

        if (expense.sharesExpenseTypesWithSplitee(splitee)) {
          return expense.copyReplacingSplitee(paidForSplitee, splitee);
        } else {
          return expense.copyRemovingSplitee(splitee);
        }
      } else if (expense.sharesExpenseTypesWithSplitee(splitee)) {
        return expense.copyAddingSplitee(splitee);
      }

      return expense;
    }

    return map(updateExpense).toList();
  }
}
