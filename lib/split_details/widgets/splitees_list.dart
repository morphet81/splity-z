import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:splity_z/split_details/widgets/splitee_list_item.dart';

class SpliteesList extends StatefulWidget {
  const SpliteesList({required this.split, required this.isInEditMode, super.key});

  final Split split;
  final bool isInEditMode;

  @override
  State<SpliteesList> createState() => _SpliteesListState();
}

class _SpliteesListState extends State<SpliteesList> {
  Splitee? _spliteeItemInEditMode;

  void _onSpliteeItemEntersEditMode(Splitee splitee) {
    _spliteeItemInEditMode = splitee;
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
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final splitee = widget.split.splitees[index];

                return SpliteeListItem(
                  split: widget.split,
                  splitee: splitee,
                  isParentInEditMode: widget.isInEditMode,
                  isInEditMode: _spliteeItemInEditMode == splitee,
                  onEnterEditMode: _onSpliteeItemEntersEditMode,
                );
              },
              itemCount: widget.split.splitees.length,
            ),
          ),
        ],
      ),
    );
  }
}
