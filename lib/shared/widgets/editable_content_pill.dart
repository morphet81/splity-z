import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:splity_z/shared/widgets/editable_content_change_dialog/editable_content_change_dialog.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

enum ContentPillType {
  string,
  decimal,
}

class EditableContentPill<T> extends StatefulWidget {
  const EditableContentPill({
    required this.content,
    required this.onChanged,
    this.textAlign = Alignment.center,
    this.allowEllipsisOverflow = true,
    this.editOnRendered = false,
    this.options = null,
    this.fixedSize = null,
    this.isRound = false,
    this.contentType = ContentPillType.string,
    this.itemLabel = null,
    super.key,
  });

  final T content;
  final void Function(T) onChanged;
  final Alignment textAlign;
  final bool allowEllipsisOverflow;
  final bool editOnRendered;
  final List<T>? options;
  final double? fixedSize;
  final bool isRound;
  final ContentPillType contentType;
  final String Function(T item)? itemLabel;

  @override
  State<EditableContentPill<T>> createState() => _EditableContentPillState<T>();
}

class _EditableContentPillState<T> extends State<EditableContentPill<T>> {
  @override
  void initState() {
    super.initState();

    if (T != String && widget.itemLabel == null) {
      throw new Exception(
          'If the type handled by EditableContentPill isn\'t String, you must provide a itemLabel function');
    }

    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        if (widget.editOnRendered) {
          handleNamePillPressed();
        }
      },
    );
  }

  void handleNamePillPressed() {
    var initialValue = widget.content;

    if (widget.contentType == ContentPillType.decimal) {
      final stringContent = widget.content as String;
      final decimalString =
          stringContent.replaceAll(new RegExp(r'[^0-9\.]'), '');
      final decimalValue = double.parse(decimalString);

      initialValue = decimalValue > 0 ? decimalValue.toString() as T : '' as T;
    }

    Future<T?> Function(BuildContext) changeNameDialog =
        getEditableContentChangeDialog<T>(
      initialValue: initialValue,
      keyboardType: widget.contentType == ContentPillType.decimal
          ? TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      itemLabel: widget.itemLabel,
      options: widget.options,
      key: widget.key,
    );

    changeNameDialog(context).then((value) {
      if (value != null) {
        widget.onChanged(value);
      }
    });
  }

  @override
  void didUpdateWidget(covariant EditableContentPill<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.editOnRendered) {
      Timer(Duration(milliseconds: 200), handleNamePillPressed);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget contentWidget = Text(
      T == String
          ? widget.content as String
          : widget.itemLabel!(widget.content),
      overflow: TextOverflow.ellipsis,
      style: context.textTheme.titleMedium!.copyWith(
        color: context.colors.onSecondaryContainer,
      ),
    );

    if (!widget.allowEllipsisOverflow) {
      contentWidget = FittedBox(
        fit: BoxFit.fill,
        child: contentWidget,
      );
    }

    final topBottomPadding = widget.isRound ? 30.0 : 4.0;

    return ElevatedButton(
      style: ButtonStyle(
        elevation: _EditableContentPillElevation(),
        shape: widget.isRound ? WidgetStatePropertyAll(CircleBorder()) : null,
        shadowColor: WidgetStatePropertyAll(context.colors.primary),
        padding: WidgetStatePropertyAll(
          EdgeInsets.only(
            left: 18.0,
            right: 18.0,
            top: topBottomPadding,
            bottom: topBottomPadding,
          ),
        ),
      ),
      child: contentWidget,
      onPressed: handleNamePillPressed,
    );
  }
}

class _EditableContentPillElevation extends WidgetStateProperty<double?> {
  @override
  double? resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.pressed)) {
      return 1;
    }

    return 4;
  }
}
