import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:provider/provider.dart';
import 'package:splity_z/shared/widgets/editable_content_change_dialog/splityz_card.dart';

import 'package:splity_z/split_details/widgets/splitees_list/splitee_list_item_content.dart';
import 'package:splity_z/shared/widgets/deletable_list_item.dart';
import 'package:splity_z/shared/widgets/confirm_dialog.dart';
import 'package:splity_z/shared/extensions/extensions.dart';
import 'package:splity_z/shared/models/models.dart';

class SpliteeListItem extends StatelessWidget {
  const SpliteeListItem({
    super.key,
    required this.split,
    required this.splitee,
    required this.onDelete,
  });

  final Split split;
  final Splitee splitee;
  final void Function(Splitee splitee) onDelete;

  @override
  Widget build(BuildContext context) {
    void deleteSplitee() {
      context.read<SplitBloc>().add(
            DeleteSplitee(
              split: split,
              splitee: splitee,
            ),
          );

      onDelete(splitee);
    }

    void handleDeleteClick() {
      deleteSplitee();
    }

    Future<bool?> handleConfirmDismiss(DismissDirection direction) async {
      final isPayee =
          split.expenses.where((expense) => expense.paidBy == splitee).length >
              0;
      if (isPayee) {
        return showConfirmDialog(
          context,
          title: context.localizations.deleteSpliteeDialogTitle,
          message: [
            context.localizations.deleteSpliteeDialogMessage1,
            context.localizations.deleteSpliteeDialogMessage2,
          ],
        );
      }

      return true;
    }

    return DeletableListItem(
      key: Key(splitee.name),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: SplityzCard(
              child: SpliteeListItemContent(
                split: split,
                splitee: splitee,
              ),
            ),
          ),
        ],
      ),
      onDelete: handleDeleteClick,
      confirmDisimiss: handleConfirmDismiss,
    );
  }
}
