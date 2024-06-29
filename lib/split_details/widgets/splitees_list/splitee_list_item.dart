import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/deletable_list_item_card.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/shared/widgets/split_bloc_undo_snack_bar.dart';
import 'package:splity_z/split_details/widgets/splitees_list/splitee_list_item_edit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final snackBar = SplitBlocUndoSnackBar(context: context);

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
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.deleteSpliteeDialogTitle),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.deleteSpliteeDialogMessage1),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(AppLocalizations.of(context)!.deleteSpliteeDialogMessage2),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.confirm),
                onPressed: () {
                  deleteSplitee();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void handleTap() {
      widget.onEnterEditMode(widget.splitee);
      setState(() {
        _isInEditMode = true;
      });
    }

    void handleDeleteClick() {
      if (widget.split.expenses.where((expense) => expense.paidBy == widget.splitee).length > 0) {
        _showMyDialog();
      } else {
        deleteSplitee();
      }
    }

    return DeletableListItemCard(
      isInEditMode: widget.isParentInEditMode,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Card.filled(
              elevation: 1,
              child: Padding(
                padding: EdgeInsets.zero,
                child: SpliteeListItemEdit(split: widget.split, splitee: widget.splitee),
              ),
            ),
          ),
        ],
      ),
      onTap: handleTap,
      onDelete: handleDeleteClick,
    );
  }
}
