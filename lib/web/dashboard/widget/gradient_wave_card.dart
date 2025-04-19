import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MaterialApp(home: Scaffold(body: Center(child: WaveCard()))));
}

class WaveCard extends StatelessWidget {
  const WaveCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Outer card with drop shadow & rounded corners
    return Container(
      width: 240,
      height: 330,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(0, 8),
            blurRadius: 28,
            spreadRadius: -9,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Wave #1
            Positioned(
              top: -300,
              left: -270,
              child: RotatingWave(
                width: 540,
                height: 700,
                duration: const Duration(seconds: 55), // or 3s if 'playing'
                gradient: const [
                  Color(0xFFaf40ff),
                  Color(0xFF5b42f3),
                  Color(0xFF00ddeb),
                ],
              ),
            ),

            // Wave #2
            Positioned(
              top: -100, // tweak position
              left: -270,
              child: RotatingWave(
                width: 540,
                height: 700,
                duration: const Duration(seconds: 50),
                gradient: const [
                  Color(0xFFaf40ff),
                  Color(0xFF5b42f3),
                  Color(0xFF00ddeb),
                ],
              ),
            ),

            // Wave #3
            Positioned(
              top: 150, // tweak position
              left: -270,
              child: RotatingWave(
                width: 540,
                height: 700,
                duration: const Duration(seconds: 45),
                gradient: const [
                  Color(0xFFaf40ff),
                  Color(0xFF5b42f3),
                  Color(0xFF00ddeb),
                ],
              ),
            ),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon
                  Icon(Icons.design_services, size: 48, color: Colors.white),
                  const SizedBox(height: 8),
                  // Title
                  const Text(
                    "UI / EX Designer",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subtitle
                  const Text(
                    "mikeandrewdesigner",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class RotatingWave extends StatefulWidget {
  final double width;
  final double height;
  final Duration duration;
  final List<Color> gradient;

  const RotatingWave({
    super.key,
    required this.width,
    required this.height,
    required this.duration,
    required this.gradient,
  });

  @override
  _RotatingWaveState createState() => _RotatingWaveState();
}

class _RotatingWaveState extends State<RotatingWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
        );
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(220),
          gradient: SweepGradient(
            colors: widget.gradient,
            stops: const [0.0, 0.6, 1.0],
          ),

        ),
      ),
    );
  }
}

