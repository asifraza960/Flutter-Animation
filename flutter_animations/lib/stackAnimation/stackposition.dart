import 'package:flutter/material.dart';

class Position extends StatefulWidget {
  const Position({super.key});

  @override
  State<Position> createState() => _PositionState();
}

double top = 0;
double left = 0;

class _PositionState extends State<Position> {
  void Move() {
    setState(() {
      left += 100;
      top += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            AnimatedPositioned(
              top: top,
              left: left,
              duration: Duration(seconds: 1),
              child: Container(height: 100, width: 100, color: Colors.blue),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Move,
        child: Icon(Icons.accessibility),
      ),
    );
  }
}
