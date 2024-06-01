import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/split_details/widgets/shares_list.dart';
import 'package:splity_z/split_details/widgets/splitees_list.dart';

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
      final split = state.findSplitWithId(widget.splitId);

      if (split == null) {
        GoRouter.of(context).replace('/error');
      }

      return Column(
        children: [
          SpliteesList(splitees: split!.splitees),
          SharesList(split: split),
        ],
      );
    });
  }
}
