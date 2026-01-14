import 'package:flutter/material.dart';
import 'login_page.dart'; // Import the new login page

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

enum LoadingPhase {
  logo,
  transition,
  text,
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  LoadingPhase _phase = LoadingPhase.logo;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for the transition
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Adjust speed of transition
      vsync: this,
    );

    // Use a curve for smoother animation
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // Start the loading sequence
    _startSequence();
  }

  Future<void> _startSequence() async {
    // 1. Show the sopal logo without any text
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() {
      _phase = LoadingPhase.transition;
    });

    // 2. Transition with persona 5 esque style with the black and red circles
    await _controller.forward();

    if (!mounted) return;
    setState(() {
      _phase = LoadingPhase.text;
    });

    // 3. Freeze the circles and it shows a text that states "Gamify Your Social Life"
    await Future.delayed(const Duration(seconds: 3));

    // Navigate to the next page
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Start white (or match logo bg)
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Logo Layer (Phase 1 & 2 - covered by transition)
          if (_phase == LoadingPhase.logo || _phase == LoadingPhase.transition)
            Center(
              child: Image.asset(
                'assets/logov1.png',
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.7,
                fit: BoxFit.contain,
              ),
            ),

          // Transition Layer (Phase 2 & 3)
          if (_phase != LoadingPhase.logo)
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: Persona5CirclePainter(_animation.value),
                  size: Size.infinite,
                );
              },
            ),

          // Text Layer (Phase 3)
          if (_phase == LoadingPhase.text)
            Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                builder: (context, opacity, child) {
                  return Opacity(
                    opacity: opacity,
                    child: const Text(
                      "Gamify Your Social Life",
                      style: TextStyle(
                        fontFamily:
                            'Roboto', // Replace with a more stylized font if available
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class Persona5CirclePainter extends CustomPainter {
  final double progress;

  Persona5CirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    // Calculate diagonal to ensure full screen coverage
    final maxRadius = size.shortestSide * 1.5;

    final paint = Paint()..style = PaintingStyle.fill;

    // P5 Red color
    final redColor = const Color(0xFFD32F2F);
    final blackColor = Colors.black;

    // Number of rings
    const int count = 8;

    // Draw expanding rings
    // We want the last ring to be big enough to cover the screen if progress is 1.0
    // But for a "transition", we typically want the new background to fill the screen.
    // If the circles are alternating Red and Black, what should be the final state?
    // "Freeze with black and red circles".
    // And Text on top.

    // Let's create a pattern of concentric circles expanding outwards.

    for (int i = count; i >= 0; i--) {
      // Logic for radius expansion:
      // Becomes larger as progress increases.
      // Differentiates based on index i.

      double offset = i * 0.15;
      double adjustedProgress = (progress - offset) * 2.0;
      // Multiplier > 1 makes them grow faster once they start.

      if (adjustedProgress < 0) continue;
      // if (adjustedProgress > 1) adjustedProgress = 1; // Uncapped for expansion off-screen

      double radius = maxRadius * adjustedProgress;

      // Alternate colors
      paint.color = (i % 2 == 0) ? redColor : blackColor;

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant Persona5CirclePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
