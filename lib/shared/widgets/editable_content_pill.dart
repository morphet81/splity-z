import 'package:flutter/material.dart';
import 'package:splity_z/split_details/utils/name_change_dialog.dart';

class EditableContentPill extends StatelessWidget {
  const EditableContentPill({required this.content, required this.onChanged, this.textAlign = Alignment.center, this.fixedSize = null, super.key});

  final String content;
  final void Function(String) onChanged;
  final Alignment textAlign;
  final double? fixedSize;

  @override
  Widget build(BuildContext context) {
    Future<String?> Function(BuildContext) changeNameDialog = getChangeNameDialog(content, key);

    void handleNamePillPressed() {
      changeNameDialog(context).then((value) {
        if (value != null) {
          onChanged(value);
        }
      });
    }

    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(Theme.of(context).primaryColorLight),
        padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.only(left: 18.0, right: 18.0, top: 4.0, bottom: 4.0)),
        minimumSize: fixedSize != null ? WidgetStatePropertyAll<Size>(Size(fixedSize!, 0)) : null,
        alignment: textAlign,
      ),
      child: Text(
        content,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onPressed: handleNamePillPressed,
    );
  }
}
