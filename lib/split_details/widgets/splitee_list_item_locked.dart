import 'package:flutter/material.dart';
import 'package:splity_z/shared/models/models.dart';

class SpliteeListItemLocked extends StatelessWidget {
  const SpliteeListItemLocked({required this.splitee, super.key});

  final Splitee splitee;

  @override
  Widget build(BuildContext context) {
    return Text(
      splitee.name,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
