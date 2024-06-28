import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expenses_list.dart';
import 'package:splity_z/split_details/widgets/shares_list/shares_list.dart';
import 'package:splity_z/split_details/widgets/splitees_list/splitees_list.dart';

class SplitDetails extends StatelessWidget {
  const SplitDetails({required this.split, required this.isInEditMode, super.key});

  final Split split;
  final bool isInEditMode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SpliteesList(
            split: split,
            isInEditMode: isInEditMode,
          ),
          ExpensesList(
            split: split,
            isInEditMode: isInEditMode,
          ),
          split.getShares().length > 0 ? SharesList(split: split) : Container(),
        ],
      ),
    );
  }
}
