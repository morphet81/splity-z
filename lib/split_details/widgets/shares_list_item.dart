import 'dart:math';

import 'package:flutter/material.dart';
import 'package:splity_z/shared/models/models.dart';

class SharesListItem extends StatelessWidget {
  const SharesListItem({required Share this.share, super.key});

  final Share share;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            share.from.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.right,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 100,
            child: ShareArrow(
              share: share,
            ),
          ),
        ),
        Expanded(
          child: Text(
            share.to.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}

class ShareArrow extends StatelessWidget {
  const ShareArrow({required Share this.share, super.key});

  final Share share;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: ArrowPainter(),
            child: Container(),
          ),
        ),
        Center(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${share.amount}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ArrowPainter extends CustomPainter {
  ArrowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    Offset a = Offset(0.0, size.height / 2.0);
    Offset b = Offset(size.width, size.height / 2.0);

    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    const arrowSize = 10;
    const arrowAngle = pi / 6;

    final dX = b.dx - a.dx;
    final dY = b.dy - a.dy;
    final angle = atan2(dY, dX);

    // Recalculate b such that it's the end of the line minus the arrow.
    final Offset subtractedB = Offset(
      b.dx - (arrowSize - 2) * cos(angle),
      b.dy - (arrowSize - 2) * sin(angle),
    );

    canvas.drawLine(a, subtractedB, paint);
    final path = Path();

    path.moveTo(b.dx - arrowSize * cos(angle - arrowAngle), b.dy - arrowSize * sin(angle - arrowAngle));
    path.lineTo(b.dx, b.dy);
    path.lineTo(b.dx - arrowSize * cos(angle + arrowAngle), b.dy - arrowSize * sin(angle + arrowAngle));
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
