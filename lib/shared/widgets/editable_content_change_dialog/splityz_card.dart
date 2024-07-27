import 'package:flutter/material.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

class SplityzCard extends StatelessWidget {
  const SplityzCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: Border.all(color: context.colors.outlineVariant),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }
}
