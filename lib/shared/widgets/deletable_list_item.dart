import 'package:flutter/material.dart';
import 'package:splity_z/shared/widgets/list_item_delete_button.dart';
import 'package:splity_z/shared/extensions/extensions.dart';

class DeletableListItem extends StatefulWidget {
  const DeletableListItem({
    required super.key,
    required this.child,
    this.isInEditMode = false,
    this.showBorder = true,
    this.onTap,
    required this.onDelete,
    this.confirmDisimiss,
  });

  final Widget child;
  final bool isInEditMode;
  final bool showBorder;
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
    final slideValue = ListItemDeleteButton.deleteButtonWidth /
        MediaQuery.of(context).size.width;

    final Animation<Offset> offsetAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(slideValue, 0.0)).animate(
      CurvedAnimation(
        parent: _controller,
        curve:
            widget.isInEditMode ? Curves.fastOutSlowIn : Curves.fastOutSlowIn,
      ),
    );

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
      child: Stack(
        children: [
          ListItemDeleteButton(
            onPressed: widget.onDelete,
          ),
          SlideTransition(
            position: offsetAnimation,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                padding: const EdgeInsets.only(left: 2.0, bottom: 2.0),
                child: CustomPaint(
                  painter: widget.showBorder ? _GradientBorderPainter() : null,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DismissibleItemBackground extends StatelessWidget {
  const _DismissibleItemBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the left border
    final leftPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.grey, Colors.transparent],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ).createShader(Rect.fromLTWH(0, 0, 0, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Paint for the bottom border
    final bottomPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.grey, Colors.transparent],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, size.height - 2.0, size.width, 0))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw the left border
    final leftPath = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height);
    canvas.drawPath(leftPath, leftPaint);

    // Draw the bottom border
    final bottomPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height);
    canvas.drawPath(bottomPath, bottomPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
