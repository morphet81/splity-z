import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

class SplitBlocUndoSnackBar extends SnackBar {
  SplitBlocUndoSnackBar({required BuildContext context, super.key})
      : super(
          content: Text(context.localizations.undoLabel),
          action: SnackBarAction(
            label: context.localizations.undo,
            onPressed: () {
              final splitBloc = context.read<SplitBloc>();
              splitBloc.undo();
            },
          ),
        );
}
