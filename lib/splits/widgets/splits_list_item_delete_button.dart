import 'package:flutter/material.dart';
import 'package:splity_z/splits/models/models.dart' as splitz;

const slideValuePixels = 50.0;

class SplitsListItemDeleteButton extends StatelessWidget {
  const SplitsListItemDeleteButton({required this.split, super.key});

  final splitz.Split split;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      width: 50.0,
      child: IconButton(
        onPressed: () {
          debugPrint('Delete');
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }
}
