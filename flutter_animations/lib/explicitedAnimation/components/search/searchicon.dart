import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animations/explicitedAnimation/components/search/searchchild.dart';

class Searchicon extends StatefulWidget {
  const Searchicon({super.key});

  @override
  State<Searchicon> createState() => _SearchiconState();
}

class _SearchiconState extends State<Searchicon>
    with SingleTickerProviderStateMixin {
  late AnimationController _searchanimationController;
  late Animation<double> _iconRotationAnimation;
  late Animation<double> _iconEndRotationAnimation;
  late Animation<double> _iconanimationPositionLeft;
  late Animation<double> _iconanimationPositionTop;
  late Animation<double> _conanimationPositionTop;
  late Animation<double> _conanimationPositionLeft;

  // Container Animations
  late Animation<Color?> _conanimationColor;
  late Animation<Color?> _conanimationBoxColor;
  late Animation<double> _conanimationHeight;
  late Animation<double> _conanimationWidth;

  bool isExpanded = false; // Toggle state

  @override
  void initState() {
    super.initState();

    _searchanimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _iconRotationAnimation = Tween(begin: 0.0, end: 4 * pi).animate(
      CurvedAnimation(
        parent: _searchanimationController,
        curve: const Interval(0.0, 0.2),
      ),
    );

    _iconanimationPositionLeft = Tween(begin: 22.0, end: 130.0).animate(
      CurvedAnimation(
        parent: _searchanimationController,
        curve: const Interval(0.2, 0.4),
      ),
    );

    _iconanimationPositionTop = Tween(begin: 310.0, end: 250.0).animate(
      CurvedAnimation(
        parent: _searchanimationController,
        curve: const Interval(0.2, 0.4),
      ),
    );

    _conanimationPositionTop = Tween(begin: 310.0, end: 250.0).animate(
      CurvedAnimation(
        parent: _searchanimationController,
        curve: const Interval(0.2, 0.4),
      ),
    );

    _conanimationPositionLeft = Tween(begin: 22.0, end: 130.0).animate(
      CurvedAnimation(
        parent: _searchanimationController,
        curve: const Interval(0.2, 0.4),
      ),
    );

    _iconEndRotationAnimation = Tween(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _searchanimationController,
        curve: const Interval(0.4, 0.6),
      ),
    );

    _conanimationColor =
        ColorTween(begin: Colors.transparent, end: Colors.white).animate(
          CurvedAnimation(
            parent: _searchanimationController,
            curve: const Interval(0.6, 0.7),
          ),
        );

    _conanimationBoxColor =
        ColorTween(begin: Colors.transparent, end: Colors.black).animate(
          CurvedAnimation(
            parent: _searchanimationController,
            curve: const Interval(0.7, 0.85),
          ),
        );

    _conanimationWidth = Tween(begin: 100.0, end: 250.0).animate(
      CurvedAnimation(
        parent: _searchanimationController,
        curve: const Interval(0.7, 0.85, curve: Curves.bounceOut),
      ),
    );

    _conanimationHeight = Tween(begin: 100.0, end: 350.0).animate(
      CurvedAnimation(
        parent: _searchanimationController,
        curve: const Interval(0.85, 1, curve: Curves.bounceOut),
      ),
    );
  }

  @override
  void dispose() {
    _searchanimationController.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    if (isExpanded) {
      _searchanimationController.reverse();
    } else {
      _searchanimationController.forward();
    }
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _searchanimationController,
          builder: (context, child) => Positioned(
            top: _conanimationPositionTop.value,
            left: _conanimationPositionLeft.value,
            child: Container(
              height: _conanimationHeight.value,
              width: _conanimationWidth.value,
              decoration: BoxDecoration(
                color: _conanimationColor.value,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _conanimationBoxColor.value ?? Colors.transparent,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: AnimatedOpacity(
                opacity: _searchanimationController.isCompleted ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: const Searchiconchild(),
              ),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _searchanimationController,
          builder: (context, child) => Positioned(
            top: _iconanimationPositionTop.value,
            left: _iconanimationPositionLeft.value,
            child: Transform.rotate(
              angle: _iconRotationAnimation.value,
              child: Transform.rotate(
                angle: _iconEndRotationAnimation.value,
                child: child,
              ),
            ),
          ),
          child: IconButton(
            onPressed: _toggleAnimation,
            icon: Icon(
              Icons.search,
              color: isExpanded ? Colors.blue : Colors.black,
              size: 35,
            ),
          ),
        ),
      ],
    );
  }
}
