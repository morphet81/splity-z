import 'package:flutter/material.dart';
import 'package:splity_z/shared/widgets/list_item_delete_button.dart';

class DeletableListItem extends StatefulWidget {
  const DeletableListItem({required this.child, required this.onTap, required this.onDelete, required this.isInEditMode, super.key});

  final Widget child;
  final void Function() onTap;
  final void Function() onDelete;
  final bool isInEditMode;

  @override
  State<DeletableListItem> createState() => _DeletableListItemState();
}

class _DeletableListItemState extends State<DeletableListItem> with SingleTickerProviderStateMixin {
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
    final slideValue = ListItemDeleteButton.DELETE_BUTTON_WIDTH / MediaQuery.of(context).size.width;

    final Animation<Offset> offsetAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(slideValue, 0.0)).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.isInEditMode ? Curves.fastOutSlowIn : Curves.fastOutSlowIn,
    ));

    if (widget.isInEditMode) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return Padding(
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
    );
  }
}
