import 'package:flutter/material.dart';

class Anitetedtween extends StatefulWidget {
  const Anitetedtween({super.key});

  @override
  State<Anitetedtween> createState() => _AnitetedtweenState();
}

double end = 200;
double begin = 50;

class _AnitetedtweenState extends State<Anitetedtween> {
  @override
  Widget build(BuildContext context) {
    Tween<double> tween = Tween<double>(begin: 0.0, end: end);
    return Scaffold(
      appBar: AppBar(title: Text("TweenAnimationBuilder Example")),
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: begin, end: end),
          duration: Duration(seconds: 2),
          curve: Curves.bounceInOut,
          builder: (context, value, child) {
            return Container(width: value, height: value, color: Colors.green);
          },
        ),
      ),
    );
  }
}
