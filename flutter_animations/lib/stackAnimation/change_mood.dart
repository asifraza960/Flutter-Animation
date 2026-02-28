import 'dart:math';
import 'package:flutter/material.dart';

class DayNightMode extends StatefulWidget {
  const DayNightMode({super.key});

  @override
  State<DayNightMode> createState() => _DayNightModeState();
}

class _DayNightModeState extends State<DayNightMode>
    with SingleTickerProviderStateMixin {
  bool isNight = false;
  late AnimationController _starController;

  @override
  void initState() {
    super.initState();
    _starController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _starController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() {
      isNight = !isNight;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Sun/Moon positions
    final sunPos = isNight
        ? Offset(screenWidth * 0.8, screenHeight * 0.15)
        : Offset(screenWidth * 0.1, screenHeight * 0.15);
    final moonPos = isNight
        ? Offset(screenWidth * 0.1, screenHeight * 0.15)
        : Offset(screenWidth * 0.8, screenHeight * 0.15);

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isNight
                    ? [Colors.indigo.shade900, Colors.black87]
                    : [Colors.blue.shade300, Colors.green.shade200],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Stars
          if (isNight)
            AnimatedBuilder(
              animation: _starController,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(screenWidth, screenHeight),
                  painter: StarPainter(_starController.value),
                );
              },
            ),
          // Sun
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            left: sunPos.dx,
            top: sunPos.dy,
            child: Icon(
              Icons.sunny,
              color: Colors.yellowAccent,
              size: screenHeight * 0.12,
              shadows: const [Shadow(color: Colors.orange, blurRadius: 8)],
            ),
          ),
          // Moon
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            left: moonPos.dx,
            top: moonPos.dy,
            child: Icon(
              Icons.dark_mode_outlined,
              color: Colors.white70,
              size: screenHeight * 0.12,
              shadows: const [Shadow(color: Colors.blueGrey, blurRadius: 8)],
            ),
          ),
          // Toggle button
          Positioned(
            bottom: 50,
            left: screenWidth * 0.5 - 60,
            child: ElevatedButton(
              onPressed: _toggleMode,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                backgroundColor: isNight ? Colors.yellowAccent : Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                isNight ? "Day Mode" : "Night Mode",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isNight ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ⭐ Star Painter for night mode
class StarPainter extends CustomPainter {
  final double animationValue;
  StarPainter(this.animationValue);

  final Random random = Random();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(animationValue);
    for (int i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height * 0.5;
      canvas.drawCircle(Offset(x, y), 2 + random.nextDouble() * 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) => true;
}
