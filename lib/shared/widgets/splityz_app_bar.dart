import 'package:flutter/material.dart' hide Split;
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/split.dart';
import 'editable_content_change_dialog/editable_content_change_dialog.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

class SplityzAppBar extends StatelessWidget {
  const SplityzAppBar({
    required this.title,
    this.split,
    this.actions = const [],
    super.key,
  });

  final String title;
  final Split? split;
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

  void handleTitleTap(BuildContext context) {
    if (split == null) {
      return;
    }

    Future<String?> Function(BuildContext) changeNameDialog =
        getEditableContentChangeDialog<String>(
      initialValue: title,
      keyboardType: TextInputType.text,
    );

    changeNameDialog(context).then((value) {
      if (value != null) {
        context.read<SplitBloc>().add(RenameSplit(value, split: split!));
      }
    });
  }

  @override
  AppBar build(BuildContext context) {
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
