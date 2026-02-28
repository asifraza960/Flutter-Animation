import 'package:flutter/material.dart';

class Homechild extends StatefulWidget {
  const Homechild({super.key});

  @override
  State<Homechild> createState() => _HomechildState();
}

class _HomechildState extends State<Homechild> {
  @override
  Widget build(BuildContext context) {
    var mqSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Home',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Divider(color: Colors.black),
      ],
    );
  }
}
