import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:splity_z/shared/extensions/extensions.dart';

Future<T?> Function(BuildContext) getEditableContentChangeDialog<T>({
  required T initialValue,
  TextInputType? keyboardType = TextInputType.text,
  List<T>? options,
  String Function(T item)? itemLabel,
  Key? key,
}) {
  return (BuildContext context) {
    if (T != String && itemLabel == null) {
      throw Exception(
        'If the type handled by EditableContentPill isn\'t String, you must provide a itemLabel function',
      );
    }

    return showDialog<T?>(
      context: context,
      builder: (BuildContext context) {
        T newName = initialValue;

        String? validateInput(String? value) {
          String? errorMessage;

          if (value == null || value.isEmpty) {
            errorMessage = context.localizations.enterStringValue;
          }

          return errorMessage;
        }

        bool isInputValid() {
          return (newName is String &&
                  validateInput(newName as String) == null) ||
              newName is! String;
        }

        return StatefulBuilder(
          builder: (context, setState) {
            void handleOnChanged(T value) {
              setState(
                () {
                  newName = value;
                },
              );
            }

            void handleEditingDone() {
              if (isInputValid()) {
                Navigator.pop(context, newName);
              } else {
                Navigator.pop(context);
              }
            }

            void handleOptionSelected(T option) {
              Navigator.pop(context, option);
            }

            void handleTextFormFieldChange(String value) {
              if (T == String) {
                handleOnChanged(value as T);
              }
            }

            final List<TextInputFormatter> inputFormatters =
                keyboardType == TextInputType.number
                    ? [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'),
                        ),
                      ]
                    : [];

            Widget editionWidget = Container();

            if (options == null) {
              editionWidget = TextFormField(
                autofocus: true,
                initialValue: T == String
                    ? initialValue as String
                    : itemLabel!(initialValue),
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                onChanged: handleTextFormFieldChange,
                onEditingComplete: handleEditingDone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validateInput,
              );
            } else {
              final optionsListHeight = options.length *
                  context.textTheme.bodyMedium!.fontSize! *
                  3.5;
              final maxOptionsListHeight =
                  MediaQuery.sizeOf(context).height * 0.7;

              final optionsListPhysics =
                  optionsListHeight < maxOptionsListHeight
                      ? NeverScrollableScrollPhysics()
                      : null;

              editionWidget = SizedBox(
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
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                    );
                  },
                  itemCount: options.length,
                ),
              );
            }

            String actionButtonText = context.localizations.confirm;

            if (options != null) {
              actionButtonText = context.localizations.cancel;
            }

            List<Widget> actions = <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: context.textTheme.labelLarge,
                ),
                onPressed: isInputValid() ? handleEditingDone : null,
                child: Text(actionButtonText),
              ),
            ];

            return AlertDialog(
              content: editionWidget,
              actions: actions,
            );
          },
        );
      },
    );
  };
}
