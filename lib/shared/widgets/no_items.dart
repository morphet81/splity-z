import 'package:flutter/material.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

class NoItems extends StatelessWidget {
  const NoItems({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 36.0,
        vertical: 42.0,
      ),
      child: Center(
        child: Text(
          message,
          style: context.textTheme.titleSmall!.copyWith(
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
