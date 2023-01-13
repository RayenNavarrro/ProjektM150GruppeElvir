import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class RadialGauge extends StatefulWidget {
  final int maxValue;
  final int currentValue;

  const RadialGauge({
    required this.maxValue,
    required this.currentValue,
    Key? key,
  }) : super(key: key);

  @override
  _RadialGaugeState createState() => _RadialGaugeState();
}

class _RadialGaugeState extends State<RadialGauge>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  double _fraction = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 225),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _MyCustomRadialGaugePainter(
        _fraction,
        widget.maxValue,
        widget.currentValue,
      ),
      child: SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: Text(
                '${widget.currentValue}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 98, 160),
                  fontSize: 60.0,
                  fontFamily: 'Saira Condensed',
                ),
              ),
            ),
            const Positioned(
              top: 75,
              child: Text(
                'freie Parkplätze',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black38,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyCustomRadialGaugePainter extends CustomPainter {
  final num maxValue;
  final num current;

  final double _fraction;

  _MyCustomRadialGaugePainter(this._fraction, this.maxValue, this.current);

  @override
  void paint(Canvas canvas, Size size) {
    final complete = Paint()
      // ..color = Color.fromARGB(255, 31, 138, 205)
      ..shader = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(size.width, size.height),
        [
          const Color.fromARGB(255, 31, 138, 205),
          const Color.fromARGB(255, 31, 138, 205),
        ],
      )
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13.0;

    final line = Paint()
      ..color = const Color(0xFFE9E9E9)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) * .75;

    const startAngle = -4 * pi / 10;
    const sweepAngle = 18 * pi / 10;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      line,
    );

    final arcAngle = (sweepAngle) * (current / maxValue);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      arcAngle * _fraction,
      false,
      complete,
    );

    // final lowerBoundText = TextPainter(textDirection: TextDirection.ltr)
    //   ..text = TextSpan(text: '0', style: TextStyle(color: Colors.grey))
    //   ..layout(minWidth: 0, maxWidth: double.maxFinite);
    // lowerBoundText.paint(
    //   canvas,
    //   Offset(-size.width * 0.42, size.height / 1.22),
    // );

    // final upperBoundText = TextPainter(textDirection: TextDirection.ltr)
    //   ..text = TextSpan(
    //     text: '$maxValue',
    //     style: const TextStyle(color: Colors.grey),
    //   )
    //   ..layout(
    //     minWidth: 0,
    //     maxWidth: double.maxFinite,
    //   );
    // upperBoundText.paint(
    //   canvas,
    //   Offset(size.width / 0.77, size.height / 1.22),
    // );
  }

  @override
  bool shouldRepaint(_MyCustomRadialGaugePainter oldDelegate) =>
      oldDelegate._fraction != _fraction;
}
