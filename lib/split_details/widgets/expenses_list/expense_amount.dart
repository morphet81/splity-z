import 'package:flutter/material.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/editable_content_pill.dart';

class ExpenseAmount extends StatelessWidget {
  const ExpenseAmount(
      {super.key,
      required this.expense,
      required this.editOnRendered,
      required this.onAmountChanged});

  final Expense expense;
  final bool editOnRendered;
  final Function(String) onAmountChanged;

  @override
  Widget build(BuildContext context) {
    return EditableContentPill<String>(
      content: '${expense.amount}',
      allowEllipsisOverflow: false,
      isRound: true,
      contentType: ContentPillType.decimal,
      editOnRendered: editOnRendered,
      onChanged: onAmountChanged,
    );
  }
}
