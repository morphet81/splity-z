import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<String?> Function(BuildContext) getChangeNameDialog(String initialName) {
  return (BuildContext context) {
    return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        String newName = initialName;

        return StatefulBuilder(builder: (context, setState) {
          void handleOnChanged(String value) {
            setState(
              () {
                newName = value;
              },
            );
          }

          void handleEditingDone() {
            Navigator.pop(context, newName);
          }

          return AlertDialog(
            content: TextFormField(
              autofocus: true,
              initialValue: initialName,
              onChanged: handleOnChanged,
              onEditingComplete: handleEditingDone,
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: Text(AppLocalizations.of(context)!.confirm),
                onPressed: handleEditingDone,
              ),
            ],
          );
        });
      },
    );
  };
}
