import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<String?> Function(BuildContext) getChangeNameDialog({required String initialValue, TextInputType? keyboardType = TextInputType.text, Key? key}) {
  return (BuildContext context) {
    return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        String newName = initialValue;

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

          final List<TextInputFormatter> inputFormatters = keyboardType == TextInputType.number
              ? [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ]
              : [];

          return AlertDialog(
            content: TextFormField(
              autofocus: true,
              initialValue: initialValue,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
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
