import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const BUTTON_WIDTH = 70.0;

enum SharingMode {
  auto,
  manual,
}

class AutoManualShareToggle extends StatelessWidget {
  const AutoManualShareToggle(
      {required this.isAuto, required this.onChanged, super.key});

  final bool isAuto;
  final Function(bool) onChanged;

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
            width: BUTTON_WIDTH,
            child: Text(
              AppLocalizations.of(context)!.auto,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        ButtonSegment<SharingMode>(
          value: SharingMode.manual,
          label: Text(AppLocalizations.of(context)!.manual),
        ),
      ],
      selected: <SharingMode>{selectedSharingMode},
      multiSelectionEnabled: false,
      onSelectionChanged: (Set<SharingMode> newSelection) {
        onChanged(newSelection.first == SharingMode.auto);
      },
    );
  }
}
