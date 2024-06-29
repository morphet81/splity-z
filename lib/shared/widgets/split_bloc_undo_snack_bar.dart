import 'package:flutter/material.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SplitBlocUndoSnackBar extends SnackBar {
  SplitBlocUndoSnackBar({required BuildContext context, super.key})
      : super(
          content: Text(AppLocalizations.of(context)!.undoLabel),
          action: SnackBarAction(
            label: AppLocalizations.of(context)!.undo,
            onPressed: () {
              final splitBloc = context.read<SplitBloc>();
              splitBloc.undo();
            },
          ),
        );
}
