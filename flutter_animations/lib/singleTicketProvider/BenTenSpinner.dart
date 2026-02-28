import 'package:flutter/material.dart';

class BenTenSpinner extends StatefulWidget {
  const BenTenSpinner({super.key});

  @override
  State<BenTenSpinner> createState() => _BenTenSpinnerState();
}

class _BenTenSpinnerState extends State<BenTenSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _rotation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  void _toggleAnimation() {
    if (_isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
    }

    setState(() {
      _isAnimating = !_isAnimating;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _circle(Color color, double size) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final circleSize = screenWidth * 0.18;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text("Ben 10 Spinner"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: _rotation,
              child: SizedBox(
                width: circleSize * 3,
                height: circleSize * 3,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: _circle(Colors.purple, circleSize),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: _circle(Colors.red, circleSize),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: _circle(Colors.brown, circleSize),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: _circle(Colors.green, circleSize),
                    ),
                    _circle(Colors.yellow, circleSize),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _toggleAnimation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                _isAnimating ? "Stop" : "Start",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
