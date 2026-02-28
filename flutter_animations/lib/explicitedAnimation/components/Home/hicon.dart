import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations/explicitedAnimation/components/Home/homechild.dart';

class Homeicon extends StatefulWidget {
  const Homeicon({super.key});

  @override
  State<Homeicon> createState() => _HomeiconState();
}

class _HomeiconState extends State<Homeicon>
    with SingleTickerProviderStateMixin {
  bool isIconFilled = false;
  late AnimationController _homeanimationController;
  late Animation<double> _iconRotation;
  late Animation<double> _iconEndRotation;
  late Animation<double> _iconPositionLeft;
  late Animation<double> _iconPositionTop;
  late Animation<double> _conPositionLeft;
  late Animation<double> _conPositionTop;
  late Animation<double> _conHeight;
  late Animation<double> _conWidth;
  late Animation<Color?> _conColor;
  late Animation<Color?> _boxShadowColor;

  @override
  void initState() {
    // Initialize Animation Controller
    _homeanimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Icon Animations
    _iconRotation = Tween(begin: 0.0, end: 4 * pi).animate(
      CurvedAnimation(
        parent: _homeanimationController,
        curve: const Interval(0.0, 0.2),
      ),
    );

    _iconPositionLeft = Tween(begin: 22.0, end: 130.0).animate(
      CurvedAnimation(
        parent: _homeanimationController,
        curve: const Interval(0.2, 0.4),
      ),
    );

    _iconPositionTop = Tween(begin: 230.0, end: 200.0).animate(
      CurvedAnimation(
        parent: _homeanimationController,
        curve: const Interval(0.2, 0.4),
      ),
    );

    _conPositionLeft = Tween(begin: 22.0, end: 130.0).animate(
      CurvedAnimation(
        parent: _homeanimationController,
        curve: const Interval(0.2, 0.4),
      ),
    );

    _conPositionTop = Tween(begin: 230.0, end: 200.0).animate(
      CurvedAnimation(
        parent: _homeanimationController,
        curve: const Interval(0.2, 0.4),
      ),
    );

    _iconEndRotation = Tween(begin: 0.0, end: 4 * pi).animate(
      CurvedAnimation(
        parent: _homeanimationController,
        curve: const Interval(0.4, 0.6, curve: Curves.bounceInOut),
      ),
    );

    // Container Animations
    _conColor = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(
          CurvedAnimation(
            parent: _homeanimationController,
            curve: const Interval(0.6, 0.7),
          ),
        );

    _boxShadowColor = ColorTween(begin: Colors.transparent, end: Colors.black)
        .animate(
          CurvedAnimation(
            parent: _homeanimationController,
            curve: const Interval(0.7, 0.85),
          ),
        );

    _conHeight = Tween(begin: 100.0, end: 350.0).animate(
      CurvedAnimation(
        parent: _homeanimationController,
        curve: const Interval(0.85, 1, curve: Curves.bounceOut),
      ),
    );

    _conWidth = Tween(begin: 100.0, end: 250.0).animate(
      CurvedAnimation(
        parent: _homeanimationController,
        curve: const Interval(0.85, 1, curve: Curves.bounceOut),
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _homeanimationController.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    if (isIconFilled) {
      _homeanimationController.reverse();
    } else {
      _homeanimationController.forward();
    }
    setState(() {
      isIconFilled = !isIconFilled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _homeanimationController,
          builder: (context, child) => Positioned(
            top: _conPositionTop.value,
            left: _conPositionLeft.value,
            child: Container(
              height: _conHeight.value,
              width: _conWidth.value,
              decoration: BoxDecoration(
                color: _conColor.value,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: _boxShadowColor.value ?? Colors.transparent,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: AnimatedOpacity(
                opacity: _homeanimationController.isCompleted ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: const Homechild(),
              ),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _homeanimationController,
          builder: (context, child) => Positioned(
            top: _iconPositionTop.value,
            left: _iconPositionLeft.value,
            child: Transform.rotate(
              angle: _iconRotation.value,
              child: Transform.rotate(
                angle: _iconEndRotation.value,
                child: child,
              ),
            ),
          ),
          child: IconButton(
            onPressed: _toggleAnimation,
            icon: Icon(
              isIconFilled ? CupertinoIcons.house_fill : CupertinoIcons.home,
              color: Colors.black,
              size: isIconFilled ? 36 : 35,
            ),
          ),
        ),
      ],
    );
  }
}
