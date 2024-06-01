import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/models/models.dart';

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
              'Splitees',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Text(
                splitShares[index].toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              );
            },
            itemCount: splitShares.length,
          ),
        ],
      ),
    );
  }
}
