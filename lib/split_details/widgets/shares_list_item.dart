import 'package:flutter/material.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/split_details/widgets/share_arrow.dart';

class SharesListItem extends StatelessWidget {
  const SharesListItem({required Share this.share, super.key});

  final Share share;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            share.from.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.right,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 100,
            child: ShareArrow(
              share: share,
            ),
          ),
        ),
        Expanded(
          child: Text(
            share.to.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
