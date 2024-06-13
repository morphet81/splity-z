import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/deletable_list_item_card.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/split_details/widgets/splitee_list_item_edit.dart';
import 'package:splity_z/split_details/widgets/splitee_list_item_locked.dart';

class SpliteeListItem extends StatefulWidget {
  const SpliteeListItem({required this.split, required this.splitee, required this.isParentInEditMode, required this.isInEditMode, required this.onEnterEditMode, super.key});

  final Split split;
  final Splitee splitee;
  final bool isParentInEditMode;
  final bool isInEditMode;
  final void Function(Splitee splitee) onEnterEditMode;

  @override
  State<SpliteeListItem> createState() => _SpliteeListItemState();
}

class _SpliteeListItemState extends State<SpliteeListItem> {
  bool _isInEditMode = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isInEditMode != _isInEditMode) {
      setState(() {
        _isInEditMode = widget.isInEditMode;
      });
    }

    return DeletableListItemCard(
      isInEditMode: widget.isParentInEditMode,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0, right: 8.0, left: 8.0),
              child: Card.filled(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SpliteeListItemEdit(splitId: widget.split.id, splitee: widget.splitee),
                  // child: _isInEditMode ? SpliteeListItemEdit(splitee: widget.splitee) : SpliteeListItemLocked(splitee: widget.splitee),
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        widget.onEnterEditMode(widget.splitee);
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
