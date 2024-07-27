import 'package:flutter/material.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

class SelectableIcon extends StatelessWidget {
  const SelectableIcon(
      {required this.icon,
      required this.isSelected,
      required this.onChange,
      super.key});

  final IconData icon;
  final bool isSelected;
  final void Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onChange(!isSelected);
      },
      icon: Icon(
        icon,
        color: isSelected
            ? context.colors.onPrimaryContainer
            : context.colors.onPrimaryContainer.withAlpha(120),
      ),
    );
  }
}
