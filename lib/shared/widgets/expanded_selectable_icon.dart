import 'package:flutter/material.dart';
import 'package:splity_z/shared/widgets/selectable_icon.dart';

class ExpandedSelectableIcon extends StatelessWidget {
  const ExpandedSelectableIcon({required this.icon, required this.onChange, super.key});

  final IconData icon;
  final void Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SelectableIcon(
        icon: icon,
        onChange: onChange,
      ),
    );
  }
}
