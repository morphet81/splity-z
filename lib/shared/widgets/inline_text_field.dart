import 'package:flutter/material.dart';

class InlineTextField extends StatelessWidget {
  const InlineTextField({required this.initialValue, this.textAlign = TextAlign.center, super.key});

  final String initialValue;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(key.toString()),
      autocorrect: false,
      autofocus: true,
      textAlign: textAlign,
      initialValue: initialValue,
      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
      ),
    );
  }
}
