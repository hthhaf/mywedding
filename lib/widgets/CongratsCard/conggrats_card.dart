import 'package:flutter/material.dart';

class CongratsCard extends StatelessWidget {

  const CongratsCard( {super.key}); 
  @override
  Widget build(BuildContext context) {
    return Container(
// Sử dụng screenWidth để đặt chiều rộng
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.pink[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'Chúc mừng hạnh phúc đôi bạn trẻ! Mong rằng tình yêu của hai bạn sẽ mãi bền chặt và tràn đầy niềm vui.',
        style: TextStyle(fontSize: 16, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ); 
  }
}