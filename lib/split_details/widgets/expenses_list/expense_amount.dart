import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/editable_content_pill.dart';
import 'package:universal_io/io.dart';

class ExpenseAmount extends StatelessWidget {
  const ExpenseAmount({super.key, required this.expense, required this.editOnRendered, required this.onAmountChanged});

  final Expense expense;
  final bool editOnRendered;
  final Function(String) onAmountChanged;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: Platform.localeName);

    return EditableContentPill<String>(
      content: formatter.format(expense.amount),
      allowEllipsisOverflow: false,
      isRound: true,
      contentType: ContentPillType.decimal,
      editOnRendered: editOnRendered,
      onChanged: onAmountChanged,
    );
  }
}
