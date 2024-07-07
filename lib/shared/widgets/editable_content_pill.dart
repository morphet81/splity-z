import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:splity_z/split_details/utils/editable_content_change_dialog/editable_content_change_dialog.dart';

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
    this.keyboardType = null,
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
  final TextInputType? keyboardType;
  final String Function(T item)? itemLabel;

  @override
  State<EditableContentPill<T>> createState() => _EditableContentPillState<T>();
}

class _EditableContentPillState<T> extends State<EditableContentPill<T>> {
  @override
  void initState() {
    super.initState();

    if (T != String && widget.itemLabel == null) {
      throw new Exception('If the type handled by EditableContentPill isn\'t String, you must provide a itemLabel function');
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
    Future<T?> Function(BuildContext) changeNameDialog = getEditableContentChangeDialog<T>(
      initialValue: widget.content,
      keyboardType: widget.keyboardType,
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
      T == String ? widget.content as String : widget.itemLabel!(widget.content),
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleMedium,
    );

    if (!widget.allowEllipsisOverflow) {
      contentWidget = FittedBox(
        fit: BoxFit.fill,
        child: contentWidget,
      );
    }

    final topBottomPadding = widget.isRound ? 30.0 : 4.0;

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColorLight,
        shape: widget.isRound ? CircleBorder() : null,
        padding: EdgeInsets.only(left: 18.0, right: 18.0, top: topBottomPadding, bottom: topBottomPadding),
        minimumSize: widget.fixedSize != null ? Size(widget.fixedSize!, 0) : null,
        alignment: widget.textAlign,
      ),
      child: contentWidget,
      onPressed: handleNamePillPressed,
    );
  }
}
