import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Notify extends StatelessWidget {
  const Notify({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double titleFontSize = width * 0.068;
        final double nameFontSize = width * 0.05;
        final double iconSize = nameFontSize * 0.8;

        return Column(
          children: [
            SizedBox(height: 12,),
            Text(
              '" Chúng mình sắp cưới rồi.. "',
              textAlign: TextAlign.center,
              style: GoogleFonts.lora(
                fontSize: titleFontSize,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(right: iconSize / 2),
                  width: width / 2 - iconSize,
                  child: Text(
                    'HÀ',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.lora(
                      fontSize: nameFontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                FaIcon(
                  FontAwesomeIcons.heart,
                  color: Colors.white,
                  size: iconSize,
                ),
                Container(
                  padding: EdgeInsets.only(left: iconSize / 2),
                  width: width / 2 - iconSize,
                  child: Text(
                    'HƯNG',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lora(
                      fontSize: nameFontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
