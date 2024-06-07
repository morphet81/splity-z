import 'package:flutter/material.dart' hide Split;

class ListItemDeleteButton extends StatelessWidget {
  const ListItemDeleteButton({required this.onPressed, super.key});

  static final double DELETE_BUTTON_WIDTH = 50.0;

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      width: ListItemDeleteButton.DELETE_BUTTON_WIDTH,
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }
}
