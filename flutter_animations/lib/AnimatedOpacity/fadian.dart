import 'package:flutter/material.dart';

class AnimatedOpacityExample extends StatefulWidget {
  const AnimatedOpacityExample({super.key});

  @override
  State<AnimatedOpacityExample> createState() => _AnimatedOpacityExampleState();
}

class _AnimatedOpacityExampleState extends State<AnimatedOpacityExample> {
  double _opacity = 1.0;
  void _toggleOpacity() {
    setState(() {
      _opacity = _opacity == 1.0
          ? 0.05
          : 1.0; // Toggle between visible and hidden
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    var Size(:height, :width) = size;
    return Scaffold(
      appBar: AppBar(title: const Text("Animated Opacity Example")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    AnimatedOpacity(
                      opacity: _opacity,
                      duration: Duration(milliseconds: 200),
                      child: Container(
                        height: height * 0.25,
                        width: width * 0.45,
                        decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _toggleOpacity,
                      child: Text(_opacity == 1 ? "unselected" : 'selected'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
