import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> showConfirmDialog(
  BuildContext context, {
  required String title,
  required List<String> message,
  required Function() onConfirm,
  Function()? onCancel,
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

  return showDialog<void>(
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
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(AppLocalizations.of(context)!.confirm),
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
