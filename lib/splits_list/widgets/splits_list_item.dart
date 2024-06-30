import 'package:flutter/material.dart' hide Split;
import 'package:provider/provider.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/deletable_list_item.dart';
import 'package:splity_z/splits_list/widgets/splits_list_item_delete_button.dart';

class SplitsListItem extends StatefulWidget {
  const SplitsListItem({required this.isInEditMode, required this.split, super.key});

  final Split split;
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
        child: Stack(
          children: [
            SplitsListItemDeleteButton(split: widget.split),
            DeletableListItem(
              child: Container(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Text(widget.split.name),
                ),
              ),
              isInEditMode: widget.isInEditMode,
              onDelete: () => debugPrint('on delete'),
              onTap: () => debugPrint('on tap'),
            )
          ],
        ),
        onDismissed: (direction) {
          context.read<SplitBloc>().add(DeleteSplit(split: widget.split));
        });
  }
}
