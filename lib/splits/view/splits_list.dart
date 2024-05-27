import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splity_z/splits/bloc/split_bloc.dart';
import 'package:splity_z/splits/widgets/splits_list_item.dart';

class SplitsList extends StatefulWidget {
  const SplitsList({required this.isInEditMode, super.key});

  final bool isInEditMode;

  @override
  State<SplitsList> createState() => _SplitsListState();
}

class _SplitsListState extends State<SplitsList> {
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
