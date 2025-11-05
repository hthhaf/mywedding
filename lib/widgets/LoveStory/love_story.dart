import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedding_web/widgets/title.dart';

class LoveStory extends StatelessWidget {

  const LoveStory( {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration
      (
        color: const Color.fromARGB(255, 211, 251, 222),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          TitleText(text: 'Chuyện đôi mình'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Tụi mình chẳng có câu chuyện đặc biệt nào, chỉ là hai người tìm thấy nhau.',
              textAlign: TextAlign.center,
              style: GoogleFonts.playfair(fontSize: 24, fontStyle:FontStyle.italic, fontWeight: FontWeight.bold  ),
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Không rực rỡ.\nKhông hoàn hảo.\nChỉ là yêu.',
              textAlign: TextAlign.center,
              style: GoogleFonts.lora(fontSize: 12, fontStyle:FontStyle.italic, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16)
        ]
        ));
  }
}
