import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/split_state.dart';
import 'package:splity_z/shared/widgets/split_bloc_undo_snack_bar.dart';
import 'package:splity_z/splits_list/widgets/splits_list_item.dart';

class SplitsList extends StatefulWidget {
  const SplitsList({required this.isInEditMode, super.key});

  final bool isInEditMode;

  @override
  State<SplitsList> createState() => _SplitsListState();
}

class _SplitsListState extends State<SplitsList> {
  void handleDeleteSplit() {
    final snackBar = SplitBlocUndoSnackBar(context: context);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplitBloc, SplitState>(
      builder: (context, state) {
        return Center(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return SplitsListItem(
                isInEditMode: widget.isInEditMode,
                split: state.splits[index],
                onDelete: handleDeleteSplit,
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: state.splits.length,
          ),
        );
      },
    );
  }
}
