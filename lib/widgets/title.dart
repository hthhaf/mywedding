import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  final String text;

  const TitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double titleSongFontSize = width * 0.05; // 5% width

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 16),
          width: width, // chiếm hết chiều ngang
          child: Text(
            text,
            textAlign: TextAlign.center, // lệch trái
            style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: titleSongFontSize,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      },
    );
  }
}
