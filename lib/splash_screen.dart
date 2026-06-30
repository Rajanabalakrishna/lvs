

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'feautres/auth/presentation/screens/login_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _textJuggleController;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Loading Bar Controller (Exactly 4 seconds)
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..forward();

    // Navigate to LoginScreen when 4 seconds are up
    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });

    // 2. Text "Juggling" Controller (Repeats back and forth)
    _textJuggleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    // Tween for a 3D rotation (front and back flip)
    _textAnimation = Tween<double>(begin: -0.3, end: 0.3).animate(
      CurvedAnimation(parent: _textJuggleController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _progressController.dispose();
    _textJuggleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Change to your brand background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- ICON/IMAGE ---
              Image.asset(
                'assets/images/img.png',
                height: 120,
                width: 120,
                // Fallback just in case the image path is wrong during testing
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_not_supported_outlined,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),

              // --- 4-SECOND LOADING BAR ---
              AnimatedBuilder(
                animation: _progressController,
                builder: (context, child) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Rounded edges
                    child: LinearProgressIndicator(
                      value: _progressController.value,
                      minHeight: 6,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),

              // --- JUGGLING TEXT ---
              AnimatedBuilder(
                animation: _textAnimation,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    // Matrix4 adds a slight 3D perspective to the flip
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002) // Perspective depth
                      ..rotateY(_textAnimation.value * math.pi), // Front/Back juggling on Y-axis
                    child: child,
                  );
                },
                child: Text(
                  'Initializing...',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}