import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/deletable_list_item.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/shared/widgets/confirm_dialog.dart';
import 'package:splity_z/split_details/widgets/splitees_list/splitee_list_item_content.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SpliteeListItem extends StatefulWidget {
  const SpliteeListItem({
    super.key,
    required this.split,
    required this.splitee,
    required this.isParentInEditMode,
    required this.isInEditMode,
    required this.onEnterEditMode,
    required this.onDelete,
  });

  final Split split;
  final Splitee splitee;
  final bool isParentInEditMode;
  final bool isInEditMode;
  final void Function(Splitee splitee) onEnterEditMode;
  final void Function(Splitee splitee) onDelete;

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

    void deleteSplitee() {
      context.read<SplitBloc>().add(
            DeleteSplitee(
              split: widget.split,
              splitee: widget.splitee,
            ),
          );

      widget.onDelete(widget.splitee);
    }

    void handleTap() {
      widget.onEnterEditMode(widget.splitee);
      setState(() {
        _isInEditMode = true;
      });
    }

    void handleDeleteClick() {
      deleteSplitee();
    }

    Future<bool?> handleConfirmDismiss(DismissDirection direction) async {
      if (widget.split.expenses
              .where((expense) => expense.paidBy == widget.splitee)
              .length >
          0) {
        return showConfirmDialog(
          context,
          title: AppLocalizations.of(context)!.deleteSpliteeDialogTitle,
          message: [
            AppLocalizations.of(context)!.deleteSpliteeDialogMessage1,
            AppLocalizations.of(context)!.deleteSpliteeDialogMessage2,
          ],
        );
      }

      return true;
    }

    return DeletableListItem(
      key: Key(widget.splitee.name),
      isInEditMode: widget.isParentInEditMode,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Card.filled(
              elevation: 1,
              child: SpliteeListItemContent(
                  split: widget.split, splitee: widget.splitee),
            ),
          ),
        ],
      ),
      onTap: handleTap,
      onDelete: handleDeleteClick,
      confirmDisimiss: handleConfirmDismiss,
    );

    // return Dismissible(
    //   key: Key(widget.split.name),
    //   direction: DismissDirection.startToEnd,
    //   background: Container(
    //     color: Colors.red,
    //     alignment: Alignment.centerLeft,
    //     child: Padding(
    //       padding: const EdgeInsets.only(left: 24),
    //       child: Text(
    //         context.localizations.delete.toUpperCase(),
    //         style: TextStyle(
    //           color: context.onPrimary,
    //           fontSize: 18,
    //         ),
    //       ),
    //     ),
    //   ),
    //   onDismissed: handleDeleteSplitee(widget.splitee),
    //   child: DeletableListItem(
    //     isInEditMode: widget.isParentInEditMode,
    //     child: Flex(
    //       direction: Axis.horizontal,
    //       children: [
    //         Expanded(
    //           child: Card.filled(
    //             elevation: 1,
    //             child: SpliteeListItemContent(
    //                 split: widget.split, splitee: widget.splitee),
    //           ),
    //         ),
    //       ],
    //     ),
    //     onTap: handleTap,
    //     onDelete: handleDeleteClick,
    //   ),
    // );
  }
}
