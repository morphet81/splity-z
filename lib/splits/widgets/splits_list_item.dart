import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:splity_z/splits/models/models.dart' as splitz;

class SplitsListItem extends StatelessWidget {
  const SplitsListItem({required this.split, super.key});

  final splitz.Split split;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text(split.name),
        ),
      ),
      onTap: () => GoRouter.of(context).push('/split/${split.id}'),
    );
  }
}
