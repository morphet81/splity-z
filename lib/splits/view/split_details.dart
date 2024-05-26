import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:splity_z/splits/bloc/split_bloc.dart';

class SplitDetails extends StatefulWidget {
  const SplitDetails({required this.splitId, super.key});

  final int splitId;

  @override
  State<SplitDetails> createState() => _SplitDetailsState();
}

class _SplitDetailsState extends State<SplitDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplitBloc, SplitState>(builder: (context, state) {
      final split = state.splits
          .where(
            (element) => element.id == widget.splitId,
          )
          .firstOrNull;

      if (split == null) {
        GoRouter.of(context).replace('/error');
      }

      return Center(
        child: Text(split!.name),
      );
    });
  }
}
