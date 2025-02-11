import 'package:flutter/material.dart' hide Split;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:splity_z/shared/extensions/extensions.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/splityz_app_bar.dart';
import 'package:splity_z/splits_list/view/splits_list.dart';

class SplitsPage extends StatefulWidget {
  const SplitsPage({super.key});

  @override
  State<SplitsPage> createState() => _SplitsListState();
}

class _SplitsListState extends State<SplitsPage> {
  bool _isInEditMode = false;

  void onEditButtonPressed() {
    setState(() {
      _isInEditMode = !_isInEditMode;
    });
  }

  void onCreateNewSplit() {
    final newSplit = Split.withName(context.localizations.newSplitName);

    context.read<SplitBloc>().add(AddSplit(split: newSplit));

    context.push('/split/${newSplit.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SplityzAppBar(
        title: context.localizations.appName,
        context: context,
        actions: [
          IconButton(
            icon: Icon(
              _isInEditMode ? Icons.done : Icons.edit,
            ),
            tooltip: context.localizations.edit,
            onPressed: onEditButtonPressed,
          ),
        ],
      ).build(),
      body: BlocBuilder(
        builder: (BuildContext context, SplitState state) {
          return SplitsList(
            isInEditMode: _isInEditMode,
          );
        },
        bloc: context.read<SplitBloc>(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateNewSplit,
        child: const Icon(Icons.add),
      ),
    );
  }
}
