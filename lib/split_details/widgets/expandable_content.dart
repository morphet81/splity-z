import 'package:flutter/material.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

class ExpandableContent extends StatefulWidget {
  const ExpandableContent({
    super.key,
    required this.title,
    required this.isExpanded,
    required this.child,
    required this.onChanged,
  });

  final String title;
  final Widget child;
  final bool isExpanded;
  final ValueChanged<bool>? onChanged;

  @override
  State<ExpandableContent> createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent> {
  final childKey = GlobalKey();

  final expandDuration = Duration(milliseconds: 200);
  final collapseDuration = Duration(milliseconds: 300);

  late bool isExpanded;
  bool hasCalculatedChildSize = false;
  Size childSize = Size.zero;

  bool get shouldExpand {
    if (widget.onChanged != null) {
      return widget.isExpanded;
    }

    return isExpanded;
  }

  @override
  void initState() {
    super.initState();

    isExpanded = widget.isExpanded;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final childBox = childKey.currentContext!.findRenderObject() as RenderBox;

      setState(() {
        hasCalculatedChildSize = true;
        childSize = childBox.size;
      });
    });
  }

  @override
  void didUpdateWidget(covariant ExpandableContent oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isExpanded != widget.isExpanded) {
      setState(() {
        isExpanded = widget.isExpanded;
      });
    }
  }

  void handleTitleTap() {
    setState(() {
      if (widget.onChanged == null) {
        isExpanded = !isExpanded;
      } else {
        widget.onChanged!(!isExpanded);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ExpandableTitle(
                title: widget.title,
                isExpanded: shouldExpand,
                onTap: handleTitleTap,
              ),
              AnimatedContainer(
                duration: isExpanded ? expandDuration : collapseDuration,
                curve: Curves.decelerate,
                height: shouldExpand ? childSize.height : 0,
                child: OverflowBox(
                  minHeight: 0,
                  maxHeight: double.infinity,
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: widget.child,
                  ),
                ),
              ),
            ],
          ),
          if (!hasCalculatedChildSize)
            Positioned(
              child: Offstage(
                offstage: true,
                child: Container(
                  key: childKey,
                  child: widget.child,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ExpandableTitle extends StatelessWidget {
  const _ExpandableTitle({
    required this.title,
    required this.isExpanded,
    required this.onTap,
  });

  final String title;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: context.textTheme.bodyLarge,
              ),
            ),
            Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
