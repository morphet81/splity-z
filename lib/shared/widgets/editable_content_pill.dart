import 'package:flutter/material.dart';
import 'package:splity_z/split_details/utils/name_change_dialog.dart';

class EditableContentPill extends StatelessWidget {
  const EditableContentPill(
      {required this.content, required this.onChanged, this.textAlign = Alignment.center, this.allowEllipsisOverflow = true, this.fixedSize = null, this.keyboardType = null, super.key});

  final String content;
  final void Function(String) onChanged;
  final Alignment textAlign;
  final bool allowEllipsisOverflow;
  final double? fixedSize;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    Future<String?> Function(BuildContext) changeNameDialog = getChangeNameDialog(initialValue: content, keyboardType: keyboardType, key: key);

    void handleNamePillPressed() {
      changeNameDialog(context).then((value) {
        if (value != null) {
          onChanged(value);
        }
      });
    }

    Widget contentWidget = Text(
      content,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleMedium,
    );

    if (!allowEllipsisOverflow) {
      contentWidget = FittedBox(
        fit: BoxFit.fill,
        child: contentWidget,
      );
    }

    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(Theme.of(context).primaryColorLight),
        padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.only(left: 18.0, right: 18.0, top: 4.0, bottom: 4.0)),
        minimumSize: fixedSize != null ? WidgetStatePropertyAll<Size>(Size(fixedSize!, 0)) : null,
        alignment: textAlign,
      ),
      child: contentWidget,
      onPressed: handleNamePillPressed,
    );
  }
}
