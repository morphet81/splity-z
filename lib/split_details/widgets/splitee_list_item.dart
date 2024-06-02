import 'package:flutter/material.dart';
import 'package:splity_z/shared/models/models.dart';

class SpliteeListItem extends StatelessWidget {
  const SpliteeListItem({required this.splitee, super.key});

  final Splitee splitee;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        splitee.name,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
