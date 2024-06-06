import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/split_details/widgets/splitee_list_item_delete_button.dart';

class SpliteeListItem extends StatelessWidget {
  const SpliteeListItem({required this.split, required this.splitee, super.key});

  final Split split;
  final Splitee splitee;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Card.filled(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  splitee.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ),
          SpliteeListItemDeleteButton(
            split: split,
            splitee: splitee,
          ),
        ],
      ),
    );
  }
}
