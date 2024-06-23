import 'package:flutter/material.dart';
import 'package:splity_z/split_details/utils/editable_content_change_dialog.dart';

class EditableContentPill<T> extends StatelessWidget {
  const EditableContentPill({
    required this.content,
    required this.onChanged,
    this.textAlign = Alignment.center,
    this.allowEllipsisOverflow = true,
    this.options = null,
    this.fixedSize = null,
    this.keyboardType = null,
    this.itemLabel = null,
    super.key,
  });

  final T content;
  final void Function(T) onChanged;
  final Alignment textAlign;
  final bool allowEllipsisOverflow;
  final List<T>? options;
  final double? fixedSize;
  final TextInputType? keyboardType;
  final String Function(T item)? itemLabel;

  @override
  Widget build(BuildContext context) {
    Future<T?> Function(BuildContext) changeNameDialog = getEditableContentChangeDialog<T>(initialValue: content, keyboardType: keyboardType, itemLabel: itemLabel, options: options, key: key);

    if (T != String && itemLabel == null) {
      throw new Exception('If the type handled by EditableContentPill isn\'t String, you must provide a itemLabel function');
    }

    void handleNamePillPressed() {
      changeNameDialog(context).then((value) {
        if (value != null) {
          onChanged(value);
        }
      });
    }

    Widget contentWidget = Text(
      T == String ? content as String : itemLabel!(content),
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
