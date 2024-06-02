import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:splity_z/split_details/widgets/shares_list_item.dart';

class SharesList extends StatelessWidget {
  const SharesList({required this.split, super.key});

  final Split split;

  @override
  Widget build(BuildContext context) {
    final splitShares = split.getShares();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              AppLocalizations.of(context)!.sharesListTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SharesListItem(share: splitShares[index]);
            },
            itemCount: splitShares.length,
          ),
        ],
      ),
    );
  }
}
