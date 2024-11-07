import 'package:flutter/material.dart' hide Split;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/split.dart';
import 'package:splity_z/shared/widgets/editable_content_change_dialog/editable_content_change_dialog.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

class SplityzAppBar {
  const SplityzAppBar({
    required this.title,
    required this.context,
    this.split,
    this.actions = const [],
  });

  final String title;
  final Split? split;
  final BuildContext context;
  final List<Widget> actions;

  Widget? backButton(BuildContext context) {
    if (context.canPop()) {
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          context.pop();
        },
      );
    }

    return null;
  }

  void handlDialogClosed(String? value) {
    if (value != null) {
      context.read<SplitBloc>().add(RenameSplit(value, split: split!));
    }
  }

  void handleTitleTap(BuildContext context) {
    if (split == null) {
      return;
    }

    Future<String?> Function(BuildContext) changeNameDialog =
        getEditableContentChangeDialog<String>(
      initialValue: title,
      keyboardType: TextInputType.text,
    );

    changeNameDialog(context).then(handlDialogClosed);
  }

  AppBar build() {
    return AppBar(
      title: GestureDetector(
        onTap: () => handleTitleTap(context),
        child: Text(
          title,
          style: context.textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      actions: actions,
      leading: backButton(context),
    );
  }
}
