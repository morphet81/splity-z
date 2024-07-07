import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:splity_z/shared/widgets/add_item_button.dart';
import 'package:splity_z/split_details/widgets/splitees_list/splitee_list_item.dart';
import 'package:provider/provider.dart';

class SpliteesList extends StatefulWidget {
  const SpliteesList({required this.split, required this.isInEditMode, super.key});

  final Split split;
  final bool isInEditMode;

  @override
  State<SpliteesList> createState() => _SpliteesListState();
}

class _SpliteesListState extends State<SpliteesList> {
  Splitee? _spliteeItemInEditMode;

  void _handleSpliteeItemEntersEditMode(Splitee splitee) {
    _spliteeItemInEditMode = splitee;
  }

  void handleAddSpliteePressed() {
    context.read<SplitBloc>().add(AddSplitee(split: widget.split));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              AppLocalizations.of(context)!.spliteeListTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index == widget.split.splitees.length) {
                    return AddItemButton(
                      onPressed: widget.isInEditMode ? null : handleAddSpliteePressed,
                    );
                  }

                  final splitee = widget.split.splitees[index];

                  return SpliteeListItem(
                    split: widget.split,
                    splitee: splitee,
                    isParentInEditMode: widget.isInEditMode,
                    isInEditMode: _spliteeItemInEditMode == splitee,
                    onEnterEditMode: _handleSpliteeItemEntersEditMode,
                  );
                },
                itemCount: widget.split.splitees.length + 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
