import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/splits/bloc/split_bloc.dart';
import 'package:splity_z/splits/models/models.dart' as splitz;
import 'package:splity_z/splits/widgets/splits_list_item_card.dart';
import 'package:splity_z/splits/widgets/splits_list_item_delete_button.dart';

class SplitsListItem extends StatefulWidget {
  const SplitsListItem(
      {required this.isInEditMode, required this.split, super.key});

  final splitz.Split split;
  final bool isInEditMode;

  @override
  State<SplitsListItem> createState() => _SplitsListItemState();
}

class _SplitsListItemState extends State<SplitsListItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(widget.split.name),
        background: Container(
          color: Colors.red,
        ),
        child: Stack(children: [
          SplitsListItemDeleteButton(split: widget.split),
          SplitsListItemCard(
              split: widget.split, isInEditMode: widget.isInEditMode),
        ]),
        onDismissed: (direction) {
          context.read<SplitBloc>().add(DeleteSplit(splitId: widget.split.id));
        });
  }
}
