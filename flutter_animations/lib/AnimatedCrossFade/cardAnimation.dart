import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  CrossFadeState crossFadeState = CrossFadeState.showFirst;

  void toggleCard() {
    setState(() {
      crossFadeState = crossFadeState == CrossFadeState.showFirst
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text("Profile Card"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;

          // Breakpoints
          bool isMobile = maxWidth < 600;
          bool isTablet = maxWidth >= 600 && maxWidth < 1100;

          double cardWidth = isMobile
              ? maxWidth * 0.9
              : isTablet
              ? 500
              : 600;

          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: cardWidth),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 700),
                      crossFadeState: crossFadeState,
                      firstChild: _buildMainCard(isMobile),
                      secondChild: _buildCompactCard(isMobile),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: toggleCard,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "View Details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainCard(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: isMobile ? 50 : 70,
            backgroundImage: const NetworkImage(
              "https://static.vecteezy.com/system/resources/thumbnails/035/314/037/small/ai-generated-professional-man-in-suit-standing-confidently-in-office-generative-ai-free-photo.jpg",
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Asif Raza",
            style: TextStyle(
              fontSize: isMobile ? 18 : 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          _infoText("Flutter Developer"),
          _infoText("+92 305 5795 960"),
          _infoText("asifraza01156@gmail.com"),
          _infoText("Punjab, Pakistan"),
        ],
      ),
    );
  }

  Widget _buildCompactCard(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E293B), Color(0xFF334155)],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: isMobile ? 40 : 60, color: Colors.white),
          const SizedBox(height: 15),
          Text(
            "Asif Raza",
            style: TextStyle(fontSize: isMobile ? 16 : 20, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            "+92 305 5795 960",
            style: TextStyle(
              fontSize: isMobile ? 14 : 18,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15, color: Colors.white70),
      ),
    );
  }
}
