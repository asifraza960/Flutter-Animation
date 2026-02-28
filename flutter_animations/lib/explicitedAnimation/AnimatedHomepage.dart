// ignore: file_names
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations/explicitedAnimation/components/Home/hicon.dart';

import 'Components/Search/SearchIcon.dart';

class Animatedhomepage extends StatefulWidget {
  const Animatedhomepage({super.key});

  @override
  State<Animatedhomepage> createState() => _AnimatedhomepageState();
}

class _AnimatedhomepageState extends State<Animatedhomepage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var mqSize = MediaQuery.of(context).size;
    return Container(
      height: mqSize.height,
      width: mqSize.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://images.pexels.com/photos/9333734/pexels-photo-9333734.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Flexible(
        flex: 100,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [Homeicon(), Searchicon()],
        ),
      ),
    );
    //
  }
}
