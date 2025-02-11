import 'package:flutter/material.dart' hide Split;
import 'package:provider/provider.dart';

import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/add_item_button.dart';
import 'package:splity_z/shared/widgets/no_items.dart';
import 'package:splity_z/shared/widgets/split_bloc_undo_snack_bar.dart';
import 'package:splity_z/split_details/widgets/splitees_list/splitee_list_item.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

class SpliteesList extends StatelessWidget {
  const SpliteesList({required this.split, super.key});

  final Split split;

  VoidCallback handleAddSpliteePressed(BuildContext context) {
    return () {
      context.read<SplitBloc>().add(AddSplitee(split: split));
    };
  }

  ValueChanged<Splitee> handleSpliteeDeletion(BuildContext context) {
    return (_) {
      final snackBar = SplitBlocUndoSnackBar(context: context);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 24),
      child: Column(
        children: [
          AddItemButton(
            label: context.localizations.addSplitee,
            onPressed: handleAddSpliteePressed(context),
          ),
          _SpliteesList(
            split: split,
            handleSpliteeDeletion: handleSpliteeDeletion(context),
          ),
        ],
      ),
    );
  }
}

class _SpliteesList extends StatelessWidget {
  const _SpliteesList({
    required this.split,
    required this.handleSpliteeDeletion,
  });

  final Split split;
  final ValueChanged<Splitee> handleSpliteeDeletion;

  @override
  Widget build(BuildContext context) {
    if (split.splitees.isEmpty) {
      return NoItems(
        message: context.localizations.spliteeListNoSplitees,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final splitee = split.splitees[index];

        return SpliteeListItem(
          split: split,
          splitee: splitee,
          onDelete: handleSpliteeDeletion,
        );
      },
      itemCount: split.splitees.length,
    );
  }
}
