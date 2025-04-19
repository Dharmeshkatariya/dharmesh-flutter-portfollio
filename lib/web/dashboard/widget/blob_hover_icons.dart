import 'package:flutter/material.dart';

import '../clipper/blob_painter.dart';

class BlobWithHoverIcons extends StatefulWidget {
  const BlobWithHoverIcons({super.key});

  @override
  _BlobWithHoverIconsState createState() => _BlobWithHoverIconsState();
}

class _BlobWithHoverIconsState extends State<BlobWithHoverIcons> {
  String _centerText = "Hover an icon to see more info";

  final List<_HoverItem> hoverItems = [
    _HoverItem(icon: Icons.phone, label: "Phone Support"),
    _HoverItem(icon: Icons.rocket, label: "Rocket Launch Services"),
    _HoverItem(icon: Icons.people, label: "Team Collaboration"),
    _HoverItem(icon: Icons.headphones, label: "24/7 Help Desk"),
    _HoverItem(icon: Icons.email, label: "Email Hosting"),
    _HoverItem(icon: Icons.cloud, label: "Cloud Solutions"),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400, // Adjust to your needs
      height: 400, // Adjust to your needs
      child: Stack(
        children: [
// 1. Blob in the center
          Center(
            child: CustomPaint(
              size: const Size(200, 220), // The size of the blob
              painter: BlobPainter(Colors.blue.shade700),
            ),
          ),

// 2. Center text over the blob
          Center(
            child: SizedBox(
              width: 180,
              height: 180,
              child: Center(
                child: Text(
                  _centerText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

// 3. Icons around the blob
// We'll place them with manual offsets or a simple approach
// so you can see how to do the MouseRegion hover logic.
          Positioned(
            left: 10,
            top: 30,
            child: _buildHoverIcon(hoverItems[0]),
          ),
          Positioned(
            right: 10,
            top: 50,
            child: _buildHoverIcon(hoverItems[1]),
          ),
          Positioned(
            left: 20,
            bottom: 20,
            child: _buildHoverIcon(hoverItems[2]),
          ),
          Positioned(
            right: 30,
            bottom: 40,
            child: _buildHoverIcon(hoverItems[3]),
          ),
          Positioned(
            left: 150,
            top: 0,
            child: _buildHoverIcon(hoverItems[4]),
          ),
          Positioned(
            right: 150,
            bottom: 0,
            child: _buildHoverIcon(hoverItems[5]),
          ),
        ],
      ),
    );
  }

// Wrap each icon in a MouseRegion to detect hover
  Widget _buildHoverIcon(_HoverItem item) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _centerText = item.label;
        });
      },
      onExit: (_) {
        setState(() {
          _centerText = "Hover an icon to see more info";
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          shape: BoxShape.circle,
        ),
        child: Icon(item.icon, color: Colors.blue.shade900),
      ),
    );
  }
}

class _HoverItem {
  final IconData icon;
  final String label;

  _HoverItem({required this.icon, required this.label});
}
