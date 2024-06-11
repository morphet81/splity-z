import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/deletable_list_item_card.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/split_details/widgets/splitee_list_item_edit.dart';
import 'package:splity_z/split_details/widgets/splitee_list_item_locked.dart';

class SpliteeListItem extends StatefulWidget {
  const SpliteeListItem({required this.split, required this.splitee, required this.isParentInEditMode, super.key});

  final Split split;
  final Splitee splitee;
  final bool isParentInEditMode;

  @override
  State<SpliteeListItem> createState() => _SpliteeListItemState();
}

class _SpliteeListItemState extends State<SpliteeListItem> {
  bool _isInEditMode = false;

  @override
  Widget build(BuildContext context) {
    return DeletableListItemCard(
      isInEditMode: widget.isParentInEditMode,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Card.filled(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _isInEditMode ? SpliteeListItemEdit(splitee: widget.splitee) : SpliteeListItemLocked(splitee: widget.splitee),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        setState(() {
          _isInEditMode = true;
        });
      },
      onDelete: () {
        context.read<SplitBloc>().add(DeleteSplitee(splitId: widget.split.id, splitee: widget.splitee));
      },
    );
  }
}
