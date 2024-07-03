import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<T?> Function(BuildContext) getEditableContentChangeDialog<T>({
  required T initialValue,
  TextInputType? keyboardType = TextInputType.text,
  List<T>? options = null,
  String Function(T item)? itemLabel = null,
  Key? key,
}) {
  return (BuildContext context) {
    if (T != String && itemLabel == null) {
      throw new Exception('If the type handled by EditableContentPill isn\'t String, you must provide a itemLabel function');
    }

    return showDialog<T?>(
      context: context,
      builder: (BuildContext context) {
        T newName = initialValue;

        return StatefulBuilder(builder: (context, setState) {
          void handleOnChanged(T value) {
            setState(
              () {
                newName = value;
              },
            );
          }

          void handleEditingDone() {
            Navigator.pop(context, newName);
          }

          void handleOptionSelected(T option) {
            Navigator.pop(context, option);
          }

          void handleTextFormFieldChange(String value) {
            if (T == String) {
              handleOnChanged(value as T);
            }
          }

          String? validateInput(String? value) {
            var errorMessage = null;

            if (value == null || value.isEmpty) {
              errorMessage = AppLocalizations.of(context)!.enterStringValue;
            }

            return errorMessage;
          }

          bool isInputValid() {
            return (newName is String && validateInput(newName as String) == null) || !(newName is String);
          }

          final List<TextInputFormatter> inputFormatters = keyboardType == TextInputType.number
              ? [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ]
              : [];

          Widget editionWidget = Container();

          if (options == null) {
            editionWidget = TextFormField(
              autofocus: true,
              initialValue: T == String ? initialValue as String : itemLabel!(initialValue),
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              onChanged: handleTextFormFieldChange,
              onEditingComplete: handleEditingDone,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validateInput,
            );
          } else {
            final optionsListHeight = options.length * Theme.of(context).textTheme.bodyMedium!.fontSize! * 3.5;
            final maxOptionsListHeight = MediaQuery.sizeOf(context).height * 0.7;

            final optionsListPhysics = optionsListHeight < maxOptionsListHeight ? NeverScrollableScrollPhysics() : null;

            editionWidget = Container(
              height: min(optionsListHeight, maxOptionsListHeight),
              width: MediaQuery.sizeOf(context).width * 0.8,
              child: ListView.builder(
                shrinkWrap: true,
                physics: optionsListPhysics,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: OutlinedButton(
                      onPressed: () {
                        handleOptionSelected(options[index]);
                      },
                      child: Text(
                        itemLabel!(options[index]),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  );
                },
                itemCount: options.length,
              ),
            );
          }

          String actionButtonText = AppLocalizations.of(context)!.confirm;

          if (options != null) {
            actionButtonText = AppLocalizations.of(context)!.cancel;
          }

          List<Widget> actions = <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(actionButtonText),
              onPressed: isInputValid() ? handleEditingDone : null,
            ),
          ];

          return AlertDialog(
            content: editionWidget,
            actions: actions,
          );
        });
      },
    );
  };
}
