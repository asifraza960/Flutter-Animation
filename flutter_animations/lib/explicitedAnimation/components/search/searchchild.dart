import 'package:flutter/material.dart';

class Searchiconchild extends StatefulWidget {
  const Searchiconchild({super.key});

  @override
  State<Searchiconchild> createState() => _SearchiconchildState();
}

class _SearchiconchildState extends State<Searchiconchild> {
  @override
  Widget build(BuildContext context) {
    final mqsize = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          width: mqsize.width * 0.5,
          height: mqsize.height * 0.05,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('Search here', style: TextStyle(fontSize: 22)),
            ),
          ),
        ),
        Divider(color: Colors.black),
      ],
    );
  }
}
