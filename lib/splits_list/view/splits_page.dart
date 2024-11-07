import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:splity_z/shared/extensions/extensions.dart';
import 'package:splity_z/shared/widgets/splityz_app_bar.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SplityzAppBar(
        title: context.localizations.appName,
        actions: [
          IconButton(
            icon: Icon(
              _isInEditMode ? Icons.done : Icons.edit,
            ),
            tooltip: context.localizations.edit,
            onPressed: onEditButtonPressed,
          ),
        ],
      ).build(context),
      body: BlocProvider(
        create: (_) => SplitBloc(),
        child: SplitsList(
          isInEditMode: _isInEditMode,
        ),
      ),
    );
  }
}
