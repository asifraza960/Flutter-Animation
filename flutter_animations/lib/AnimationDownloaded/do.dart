import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animations/AnimationDownloaded/ArcPainter.dart';
import 'package:flutter_animations/AnimationDownloaded/LinearPainter.dart';

class DownloadAnimation extends StatefulWidget {
  const DownloadAnimation({super.key});

  @override
  State<DownloadAnimation> createState() => _DownloadAnimationState();
}

class _DownloadAnimationState extends State<DownloadAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationOpacity;
  late Animation<double> _animationWidth;
  late Animation<double> _animationTextSize;
  late Animation<double> _animationArcEnd;
  late Animation<Offset> _animationLine1;
  late Animation<Offset> _animationLine2;

  // ✅ Correct Offset Declaration (Without Animation)
  late Offset linepoint1;
  late Offset linepoint2;
  late Offset commonline;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animationWidth = Tween<double>(begin: 200.0, end: 100.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.100, curve: Curves.ease),
      ),
    );

    _animationTextSize = Tween<double>(begin: 25.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.100, curve: Curves.ease),
      ),
    );

    _animationOpacity =
        TweenSequence([
          TweenSequenceItem(
            tween: Tween(
              begin: 0.0,
              end: 1.0,
            ).chain(CurveTween(curve: Curves.ease)),
            weight: 50.0,
          ),
          TweenSequenceItem(
            tween: Tween(
              begin: 1.0,
              end: 0.0,
            ).chain(CurveTween(curve: Curves.ease)),
            weight: 50.0,
          ),
        ]).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.020, 0.400),
          ),
        );

    _animationArcEnd = Tween<double>(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.200, 0.750, curve: Curves.linear),
      ),
    );

    // ✅ Initialize Offset Values (Correct way)
    linepoint1 = const Offset(-15, 5);
    linepoint2 = const Offset(-5, 15);
    commonline = const Offset(20, -10);

    _animationLine1 = Tween<Offset>(begin: linepoint1, end: commonline).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.800, 0.850, curve: Curves.linear),
      ),
    );

    _animationLine2 = Tween<Offset>(begin: commonline, end: linepoint2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.850, 0.950, curve: Curves.ease),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            if (_animationController.status == AnimationStatus.dismissed ||
                _animationController.status == AnimationStatus.completed) {
              _animationController.forward();
            }
          },
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 100,
                    width: _animationWidth.value,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.green, width: 10),
                    ),
                    child: Center(
                      child: Text(
                        "Download",
                        style: TextStyle(
                          fontSize: _animationTextSize.value,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: _animationOpacity.value,
                    child: const Icon(
                      Icons.arrow_downward,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  CustomPaint(
                    painter: ArcPainter(
                      startAngle: -pi / 2,
                      endAngle: _animationArcEnd.value,
                    ),
                  ),
                  CustomPaint(
                    painter: LinearPainter(
                      _animationLine1,
                      _animationLine2,
                      linepoint1,
                      commonline, // ✅ No need for "as Offset"
                      linepoint2, // ✅ No need for "as Offset"
                      // ✅ No need for "as Offset"
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
