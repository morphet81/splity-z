import 'package:flutter/material.dart' hide Split;
import 'package:go_router/go_router.dart';
import 'package:splity_z/shared/models/models.dart';

const slideValuePixels = 50.0;

class SplitsListItemCard extends StatefulWidget {
  const SplitsListItemCard(
      {required this.split, required this.isInEditMode, super.key});

  final Split split;
  final bool isInEditMode;

  @override
  State<SplitsListItemCard> createState() => _SplitsListItemCardState();
}

class _SplitsListItemCardState extends State<SplitsListItemCard>
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
    final slideValue = slideValuePixels / MediaQuery.of(context).size.width;

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

    return SlideTransition(
      position: offsetAnimation,
      child: GestureDetector(
        child: Container(
          color: Theme.of(context).cardColor,
          child: ListTile(
            title: Text(widget.split.name),
          ),
        ),
        onTap: () => GoRouter.of(context).push('/split/${widget.split.id}'),
      ),
    );
  }
}
