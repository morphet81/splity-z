import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splity_z/splits/bloc/split_bloc.dart';
import 'package:splity_z/splits/splits.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appName,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                )),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: Icon(
              _isInEditMode ? Icons.done : Icons.edit,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            tooltip: 'Edit',
            onPressed: onEditButtonPressed,
          )
        ],
      ),
      body: BlocProvider(
        create: (_) => SplitBloc(),
        child: SplitsList(
          isInEditMode: _isInEditMode,
        ),
      ),
    );
  }
}
