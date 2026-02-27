import 'package:flutter/material.dart';

class Switcher extends StatefulWidget {
  const Switcher({super.key});

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  static const String _firstImage =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo8ecjL5DItbUDCqR7LuHDKfXt6PzdaTESzA&s";

  static const String _secondImage =
      "https://cdn.pixabay.com/photo/2020/12/19/02/50/emoji-5843434_640.png";

  CrossFadeState _crossFadeState = CrossFadeState.showFirst;

  void _toggleEmoji() {
    setState(() {
      _crossFadeState = _crossFadeState == CrossFadeState.showFirst
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst;
    });
  }

  Widget _buildAvatar(String imageUrl) {
    return CircleAvatar(radius: 100, backgroundImage: NetworkImage(imageUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          "AnimatedCrossFade",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedCrossFade(
              firstChild: _buildAvatar(_firstImage),
              secondChild: _buildAvatar(_secondImage),
              crossFadeState: _crossFadeState,
              duration: const Duration(milliseconds: 800),
              firstCurve: Curves.easeIn,
              secondCurve: Curves.easeOut,
              sizeCurve: Curves.easeInOut,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleEmoji,
              style: ElevatedButton.styleFrom(minimumSize: const Size(140, 50)),
              child: const Text("Switch Emoji"),
            ),
          ],
        ),
      ),
    );
  }
}
