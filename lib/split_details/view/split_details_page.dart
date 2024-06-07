import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:splity_z/shared/widgets/splityz_app_bar.dart';
import 'package:splity_z/split_details/view/split_details.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplitDetailsPage extends StatefulWidget {
  const SplitDetailsPage({required this.splitId, super.key});

  final int splitId;

  @override
  State<SplitDetailsPage> createState() => _SplitDetailsPageState();
}

class _SplitDetailsPageState extends State<SplitDetailsPage> {
  bool _isInEditMode = false;

  void onEditButtonPressed() {
    setState(() {
      _isInEditMode = !_isInEditMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplitBloc>(
      create: (_) => SplitBloc(),
      child: BlocBuilder<SplitBloc, SplitState>(
        builder: (context, state) {
          final split = state.splits
              .where(
                (element) => element.id == widget.splitId,
              )
              .firstOrNull;

          if (split == null) {
            GoRouter.of(context).replace('/error');
          }

          return Scaffold(
            appBar: SplityzAppBar(
              title: split!.name,
              actions: [
                IconButton(
                  icon: Icon(
                    _isInEditMode ? Icons.done : Icons.edit,
                  ),
                  tooltip: AppLocalizations.of(context)!.edit,
                  onPressed: onEditButtonPressed,
                )
              ],
            ).build(context),
            body: SplitDetails(
              split: split,
              isInEditMode: _isInEditMode,
            ),
          );
        },
      ),
    );
  }
}
