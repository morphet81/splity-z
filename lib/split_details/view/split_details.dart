import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/extensions/extensions.dart';

import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/split_details/widgets/expenses_list/expenses_list.dart';
import 'package:splity_z/split_details/widgets/shares_list/shares_list.dart';
import 'package:splity_z/split_details/widgets/splitees_list/splitees_list.dart';

class SplitDetails extends StatefulWidget {
  const SplitDetails({
    super.key,
    required this.split,
  });

  final Split split;

  @override
  State<SplitDetails> createState() => _SplitDetailsState();
}

class _SplitDetailsState extends State<SplitDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          SharesList(split: widget.split),
          TabBar(
            tabs: [
              Tab(
                child: Text(
                  context.localizations.spliteeListTitle,
                  style: context.textTheme.headlineSmall,
                ),
              ),
              Tab(
                child: Text(
                  context.localizations.expensesListTitle,
                  style: context.textTheme.headlineSmall,
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: SpliteesList(
                      split: widget.split,
                    ),
                  ),
                  SingleChildScrollView(
                    child: ExpensesList(
                      split: widget.split,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
