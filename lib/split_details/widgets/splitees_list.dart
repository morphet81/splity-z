import 'package:flutter/material.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:splity_z/split_details/widgets/splitee_list_item.dart';

class SpliteesList extends StatelessWidget {
  const SpliteesList({required this.splitees, super.key});

  final List<Splitee> splitees;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              AppLocalizations.of(context)!.spliteeListTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SpliteeListItem(splitee: splitees[index]);
            },
            itemCount: splitees.length,
          ),
        ],
      ),
    );
  }
}
