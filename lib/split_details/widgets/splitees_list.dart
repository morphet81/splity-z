import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:splity_z/split_details/widgets/splitee_list_item.dart';

class SpliteesList extends StatelessWidget {
  const SpliteesList({required this.split, super.key});

  final Split split;

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
              if (index == split.splitees.length) {
                return Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                );
              } else {
                return SpliteeListItem(split: split, splitee: split.splitees[index]);
              }
            },
            itemCount: split.splitees.length + 1,
          ),
        ],
      ),
    );
  }
}
