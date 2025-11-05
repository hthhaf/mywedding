import 'package:flutter/material.dart';

class Cover extends StatelessWidget {

  const Cover({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1, // 1:1 (vuông)
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
          ),
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
