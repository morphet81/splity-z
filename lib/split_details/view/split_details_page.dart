import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:splity_z/shared/models/split_state.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

import 'package:splity_z/shared/widgets/splityz_app_bar.dart';
import 'package:splity_z/split_details/view/split_details.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';

class SplitDetailsPage extends StatelessWidget {
  const SplitDetailsPage({required this.splitId, super.key});

  final String splitId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplitBloc, SplitState>(
      builder: (context, state) {
        final split = state.splits
            .where(
              (element) => element.id == splitId,
            )
            .firstOrNull;

        if (split == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.push('/error');
          });

          return Container();
        }

        return Scaffold(
          appBar: SplityzAppBar(
            title: split.name,
            split: split,
            context: context,
          ).build(),
          backgroundColor: context.colors.surfaceContainer,
          body: SplitDetails(
            split: split,
          ),
        );
      },
    );
  }
}
