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
    return Card.filled(
      // elevation: 2,
      margin: EdgeInsets.zero,
      color: context.colors.primaryContainer,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: child,
    );
  }
}
