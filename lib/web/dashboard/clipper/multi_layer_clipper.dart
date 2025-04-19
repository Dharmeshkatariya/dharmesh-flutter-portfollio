import 'package:flutter/material.dart';
import 'package:vikram_portfollio_dark/web/dashboard/clipper/wave_clipper.dart';
import 'deep_wave_clipper.dart';
import 'double_wave_clipper.dart';

class MultiLayerWave extends StatelessWidget {
  const MultiLayerWave({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: DeepWaveClipper(),
          child: Container(
            height: 100,
            color: Colors.blue.withOpacity(0.3),
          ),
        ),
        ClipPath(
          clipper: DoubleWaveClipper(),
          child: Container(
            height: 90,
            color: Colors.blue.withOpacity(0.5),
          ),
        ),
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 80,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
