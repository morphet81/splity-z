import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool?> showConfirmDialog(
  BuildContext context, {
  required String title,
  required List<String> message,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) async {
  if (message.length == 0) {
    throw new Exception('Message should contain at least 1 line');
  }

  final messageFirstLine = message[0];

  message.removeAt(0);

  Widget messageLine(messageLineText) => Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text(AppLocalizations.of(context)!.deleteSpliteeDialogMessage2),
      );

  return showDialog<bool?>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(messageFirstLine),
              ...message.map(messageLine).toList(),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context)!.cancel),
            onPressed: () {
              onCancel?.call();
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text(AppLocalizations.of(context)!.confirm),
            onPressed: () {
              onConfirm?.call();
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
