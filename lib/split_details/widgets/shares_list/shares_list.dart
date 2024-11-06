import 'package:flutter/material.dart' hide Split;

import 'package:splity_z/shared/extensions/extensions.dart';
import 'package:splity_z/shared/widgets/no_items.dart';
import 'package:splity_z/split_details/widgets/shares_list/shares_list_item.dart';
import 'package:splity_z/shared/models/models.dart';

class SharesList extends StatelessWidget {
  const SharesList({required this.split, super.key});

  final Split split;

  Widget itemBuilder(BuildContext context, int index) {
    final splitShares = split.getShares();

    return SharesListItem(share: splitShares[index]);
  }

  @override
  Widget build(BuildContext context) {
    final splitShares = split.getShares();

    if (splitShares.isEmpty) {
      return NoItems(
        message: context.localizations.sharesNoShares,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 24.0,
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: itemBuilder,
        itemCount: splitShares.length,
      ),
    );
  }
}
