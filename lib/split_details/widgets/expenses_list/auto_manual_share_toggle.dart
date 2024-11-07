import 'package:flutter/material.dart';

import 'package:splity_z/shared/extensions/extensions.dart';

const buttonWidth = 70.0;

enum SharingMode {
  auto,
  manual,
}

class AutoManualShareToggle extends StatelessWidget {
  const AutoManualShareToggle({
    super.key,
    required this.isAuto,
    required this.onChanged,
  });

  final bool isAuto;
  final Function(bool) onChanged;

  void handleSelectionChanged(Set<SharingMode> newSelection) {
    onChanged(newSelection.first == SharingMode.auto);
  }

  @override
  Widget build(BuildContext context) {
    SharingMode selectedSharingMode =
        isAuto ? SharingMode.auto : SharingMode.manual;

    return SegmentedButton<SharingMode>(
      showSelectedIcon: false,
      segments: <ButtonSegment<SharingMode>>[
        ButtonSegment<SharingMode>(
          value: SharingMode.auto,
          label: SizedBox(
            width: buttonWidth,
            child: Text(
              context.localizations.auto,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        ButtonSegment<SharingMode>(
          value: SharingMode.manual,
          label: Text(context.localizations.manual),
        ),
      ],
      selected: <SharingMode>{selectedSharingMode},
      multiSelectionEnabled: false,
      onSelectionChanged: handleSelectionChanged,
    );
  }
}
