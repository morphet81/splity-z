import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/deletable_list_item_card.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/split_details/widgets/splitees_list/splitee_list_item_edit.dart';

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

    final namePill = Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
          ),
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Container(
          width: 100.0,
          child: Text(
            widget.splitee.name,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    return DeletableListItemCard(
      isInEditMode: widget.isParentInEditMode,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Card.filled(
              elevation: 1,
              child: Padding(
                // padding: const EdgeInsets.all(8.0),
                padding: EdgeInsets.zero,
                child: SpliteeListItemEdit(split: widget.split, splitee: widget.splitee),
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
        debugPrint('Delete splitee ${widget.splitee.name}');
        context.read<SplitBloc>().add(DeleteSplitee(split: widget.split, splitee: widget.splitee));
      },
    );
  }
}
