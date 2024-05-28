import 'package:flutter/material.dart';
import 'package:splity_z/shared/models/models.dart';

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
              'Splitees',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Text(
                splitees[index].name,
                style: Theme.of(context).textTheme.bodyMedium,
              );
            },
            itemCount: splitees.length,
          ),
        ],
      ),
    );
  }
}
