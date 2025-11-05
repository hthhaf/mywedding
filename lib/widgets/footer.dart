import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '2025 • Designed & developed by Hà',
      style: TextStyle(fontSize: 14, color: Colors.white),
      textAlign: TextAlign.center,
    );
  }
}
