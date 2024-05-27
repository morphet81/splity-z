import 'package:flutter/material.dart';

class SplityzAppBar extends StatelessWidget {
  const SplityzAppBar({this.title = '', this.actions = const [], super.key});

  final String title;
  final List<Widget> actions;

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      actions: actions,
    );
  }
}
