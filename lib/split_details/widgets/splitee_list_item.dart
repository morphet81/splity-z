import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/deletable_list_item_card.dart';
import 'package:provider/provider.dart';

class SpliteeListItem extends StatelessWidget {
  const SpliteeListItem({required this.split, required this.splitee, required this.isInEditMode, super.key});

  final Split split;
  final Splitee splitee;
  final bool isInEditMode;

  @override
  Widget build(BuildContext context) {
    return DeletableListItemCard(
      slideValuePixels: 40.0,
      isInEditMode: isInEditMode,
      child: Flex(
        direction: Axis.horizontal,
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
        ],
      ),
      onTap: () => debugPrint('Tap the item'),
      onDelete: () {
        context.read<SplitBloc>().add(DeleteSplitee(splitId: split.id, splitee: splitee));
      },
    );
  }
}
