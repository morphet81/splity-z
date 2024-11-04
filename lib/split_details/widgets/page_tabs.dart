import 'package:flutter/material.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

enum PageTab {
  splitees,
  expenses,
  shares,
}

class PageTabs extends StatelessWidget {
  const PageTabs({
    super.key,
    required this.currentTab,
    required this.onTabPressed,
  });

  final PageTab currentTab;
  final ValueChanged<PageTab> onTabPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _PageTab(
          label: context.localizations.spliteeListTitle,
          onPressed: () => onTabPressed(PageTab.splitees),
        ),
        _PageTab(
          label: context.localizations.expensesListTitle,
          onPressed: () => onTabPressed(PageTab.expenses),
        ),
        _PageTab(
          label: context.localizations.sharesListTitle,
          onPressed: () => onTabPressed(PageTab.shares),
        ),
      ],
    );
  }
}

class _PageTab extends StatelessWidget {
  const _PageTab({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.zero),
          backgroundColor: _PageTabBackgound(context: context),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                side: BorderSide(color: Colors.red)),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(color: context.primaryColor),
        ),
      ),
    );
  }
}

class _PageTabBackgound extends WidgetStateProperty<Color> {
  _PageTabBackgound({required this.context});

  final BuildContext context;

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.pressed)) {
      return context.colors.secondaryContainer;
    }

    return context.colors.primaryContainer;
  }
}
