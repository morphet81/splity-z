import 'package:flutter/material.dart';

class SplityzCard extends StatelessWidget {
  const SplityzCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: Border.all(color: Colors.transparent),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
