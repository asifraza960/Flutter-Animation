import 'dart:math';
import 'package:flutter/material.dart';

class BoxesRotation extends StatefulWidget {
  const BoxesRotation({super.key});

  @override
  State<BoxesRotation> createState() => _BoxesRotationState();
}

class _BoxesRotationState extends State<BoxesRotation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) => _buildAnimatedBox(index)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _animationController.forward(from: 0.0);
        },
        child: Icon(Icons.play_arrow_rounded),
      ),
    );
  }

  Widget _buildAnimatedBox(int index) {
    final delay = index * 0.15; // Staggered delay

    final start = delay;
    final end = (delay + 0.6).clamp(0.0, 1.0);

    final rotationAnimation = Tween(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(start, end, curve: Curves.easeOut),
      ),
    );

    final opacityAnimation = Tween(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(start, end, curve: Curves.easeIn),
      ),
    );

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: opacityAnimation.value,
          child: Transform.rotate(
            angle: rotationAnimation.value, // Fixed animation value
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              width: 100,
              height: 100,
              color: Colors.blueAccent,
            ),
          ),
        );
      },
    );
  }
}
