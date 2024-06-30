import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/editable_content_pill.dart';

class ExpenseAmount extends StatelessWidget {
  const ExpenseAmount({super.key, required this.expense, required this.onAmountChanged});

  final Expense expense;
  final Function(String) onAmountChanged;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: Platform.localeName);

    return EditableContentPill<String>(
      content: formatter.format(expense.amount),
      allowEllipsisOverflow: false,
      isRound: true,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      onChanged: onAmountChanged,
    );
  }
}
