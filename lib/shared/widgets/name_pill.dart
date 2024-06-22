import 'package:flutter/material.dart';

class NamePill extends StatelessWidget {
  const NamePill({required this.name, required this.onPressed, super.key});

  final String name;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: -(Theme.of(context).textTheme.titleMedium?.fontSize ?? 12) * 1.4,
      child: Align(
        alignment: Alignment.topCenter,
        child: OutlinedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(Theme.of(context).primaryColorLight),
            padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.only(left: 18.0, right: 18.0, top: 4.0, bottom: 4.0)),
            minimumSize: WidgetStatePropertyAll<Size>(Size(200, 0)),
          ),
          child: Text(
            name,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
