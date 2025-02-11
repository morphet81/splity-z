import 'package:flutter/material.dart';

class AddItemButton extends StatelessWidget {
  const AddItemButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      label: Text(label),
    );
  }
}
