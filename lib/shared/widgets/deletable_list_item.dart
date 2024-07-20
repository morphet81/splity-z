import 'package:flutter/material.dart';
import 'package:splity_z/shared/widgets/list_item_delete_button.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

class DeletableListItem extends StatefulWidget {
  const DeletableListItem({
    required super.key,
    required this.child,
    required this.isInEditMode,
    this.onTap,
    required this.onDelete,
    this.confirmDisimiss,
  });

  final Widget child;
  final bool isInEditMode;
  final VoidCallback? onTap;
  final VoidCallback onDelete;
  final ConfirmDismissCallback? confirmDisimiss;

  @override
  State<DeletableListItem> createState() => _DeletableListItemState();
}

class _DeletableListItemState extends State<DeletableListItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 350),
    vsync: this,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slideValue = ListItemDeleteButton.DELETE_BUTTON_WIDTH /
        MediaQuery.of(context).size.width;

    final Animation<Offset> offsetAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(slideValue, 0.0))
            .animate(CurvedAnimation(
      parent: _controller,
      curve: widget.isInEditMode ? Curves.fastOutSlowIn : Curves.fastOutSlowIn,
    ));

    if (widget.isInEditMode) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    void handleSwipeDeletion(DismissDirection direction) {
      widget.onDelete();
    }

    Future<bool?> handleConfirmDismiss(DismissDirection direction) async {
      if (widget.confirmDisimiss != null) {
        return widget.confirmDisimiss!(direction);
      }

      return true;
    }

    return Dismissible(
      key: widget.key!,
      direction: DismissDirection.endToStart,
      background: _DismissibleItemBackground(),
      onDismissed: handleSwipeDeletion,
      confirmDismiss: handleConfirmDismiss,
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.0),
        child: Stack(
          children: [
            ListItemDeleteButton(
              onPressed: widget.onDelete,
            ),
            SlideTransition(
              position: offsetAnimation,
              child: GestureDetector(
                child: widget.child,
                onTap: widget.onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DismissibleItemBackground extends StatelessWidget {
  const _DismissibleItemBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Text(
            context.localizations.delete.toUpperCase(),
            style: TextStyle(
              color: context.onPrimary,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
