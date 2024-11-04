import 'package:flutter/material.dart' hide Split;

import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expenses_list.dart';
import 'package:splity_z/split_details/widgets/page_tabs.dart';
import 'package:splity_z/split_details/widgets/shares_list/shares_list.dart';
import 'package:splity_z/split_details/widgets/splitees_list/splitees_list.dart';

class SplitDetails extends StatelessWidget {
  const SplitDetails({
    super.key,
    required this.split,
  });

  final Split split;

  void handleTabPressed(PageTab tab) {}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.blue,
            width: double.infinity,
            height: 30,
          ),
          PageTabs(
            currentTab: PageTab.splitees,
            onTabPressed: handleTabPressed,
          ),
          SpliteesList(
            split: split,
          ),
          ExpensesList(
            split: split,
          ),
          if (split.getShares().length > 0) SharesList(split: split),
        ],
      ),
    );
  }
}
